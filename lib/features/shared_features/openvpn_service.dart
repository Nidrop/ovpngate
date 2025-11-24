import 'dart:async';

import 'package:flutter/foundation.dart' show debugPrint;
import 'package:openvpn_flutter/openvpn_flutter.dart';
import 'package:ovpngate/core/domain/entity/vpn_stage.dart';
import 'package:ovpngate/core/domain/repository/vpn_service.dart';
import 'package:ovpngate/features/shared_features/one_day_file_cache_manager.dart';

class OpenvpnService implements VpnService {
  OpenVPN openvpn = OpenVPN();
  VpnStage _vpnStage = VpnService.defaultVpnStage;
  bool configCipherFix;
  String? _serverName;
  final String serverNameCacheKey;
  final StreamController<VpnStage> stageSC =
      StreamController<VpnStage>.broadcast();

  final OneDayFileCacheManager cacheManager;

  @override
  Stream<VpnStage> get stageStream => stageSC.stream;

  @override
  VpnStage get vpnstage => _vpnStage;

  @override
  String? get serverName => _serverName;

  OpenvpnService({
    required this.cacheManager,
    required this.configCipherFix,
    required this.serverNameCacheKey,
  });

  Future<void> ensureInitialized() async {
    if (openvpn.initialized) {
      return;
    }

    openvpn = OpenVPN(
      onVpnStatusChanged: _onVpnStatusChanged,
      onVpnStageChanged: _onVpnStageChanged,
    );

    await openvpn.initialize(
      // groupIdentifier: 'vpngate.net',
      // providerBundleIdentifier: 'net.vpn.ovpngate',
      localizedDescription: 'oVPNGate',
    );

    _vpnStage = _VPNstageToDomain(await openvpn.stage());
    stageSC.add(_vpnStage);
    //workaround to get serverName on init if connection is still established
    _serverName = (_vpnStage != VpnStage.disconnected)
        ? await cacheManager.read(key: serverNameCacheKey)
        : null;
  }

  void _onVpnStatusChanged(VpnStatus? vpnStatus) {}

  void _onVpnStageChanged(VPNStage stage, String rawStage) {
    debugPrint('DEBUG: $rawStage');
    _vpnStage = _VPNstageToDomain(stage);
    stageSC.add(_vpnStage);
  }

  // ignore: non_constant_identifier_names
  VpnStage _VPNstageToDomain(VPNStage stage) {
    return VpnStage.values.byName(stage.name);
  }

  String _configPatches(String ovpnConfig) {
    if (configCipherFix) {
      final result = ovpnConfig.replaceAll(RegExp(r'cipher '), 'data-ciphers ');
      return result;
    }
    return ovpnConfig;
  }

  @override
  void connect({required String serverName, required String config}) {
    openvpn.connect(
      _configPatches(config),
      serverName,
      // username: username,
      // password: password,
      // bypassPackages: [],
      certIsRequired: true,
    );

    _serverName = serverName;
    cacheManager.save(key: serverNameCacheKey, content: serverName);
  }

  @override
  void disconnect() {
    switch (_vpnStage) {
      case VpnStage.disconnected || VpnStage.disconnecting:
        return;
      default:
        _serverName = null;
        openvpn.disconnect();
    }
  }
}
