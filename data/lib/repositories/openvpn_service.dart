import 'dart:async';
import 'dart:convert';

import 'package:core/core.dart';
import 'package:data/mapper/openvpn_mapper.dart';
import 'package:data/mapper/server_info_mapper.dart';
import 'package:data/providers/local_data_provider.dart';
import 'package:domain/models/server_info.dart';
import 'package:domain/repositories/i_vpn_service.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';

class OpenvpnService implements IVpnService {
  @override
  ServerInfo? server;
  @override
  EnVPNStage vpnstage;
  @override
  StreamController stageSC = StreamController<EnVPNStage>.broadcast();

  @override
  Stream get stageStream => stageSC.stream;

  final LocalDataProvider localStorage;
  late final OpenVPN openvpn;
  bool configCipherFix;

  OpenvpnService({
    this.configCipherFix = true,
    this.vpnstage = EnVPNStage.unknown,
    required this.localStorage,
  }) {
    openvpn = OpenVPN(
      // onVpnStatusChanged: _onVpnStatusChanged,
      onVpnStageChanged: _onVpnStageChanged,
    );
    openvpn.initialize(
      localizedDescription: 'oVPNGate',
    );
    openvpn.stage().then((stage) {
      readLastConnectedServer().then((lastServer) {
        vpnstage = OpenvpnMapper.vpnstageToEnvpnstage(stage);
        server = (stage != VPNStage.disconnected) ? lastServer : null;
      });
    });
  }

  void _onVpnStatusChanged(VpnStatus? vpnStatus) {}

  void _onVpnStageChanged(VPNStage stage, String rawStage) {
    vpnstage = OpenvpnMapper.vpnstageToEnvpnstage(stage);
    stageSC.add(vpnstage);
  }

  String _configPatches(String ovpnConfig) {
    if (configCipherFix) {
      final result = ovpnConfig.replaceAll(RegExp(r'cipher '), 'data-ciphers ');
      return result;
    }
    return ovpnConfig;
  }

  Future<ServerInfo?> readLastConnectedServer() async {
    final str = await localStorage.read(StorageConstants.currentVpnSessionFile);
    if (str == null) return null;
    return ServerInfo(
      speed: -1,
      countryShort: '',
      sessions: -1,
      uptime: -1,
      name: str,
      ovpnConfig: '',
    );
  }

  Future<void> saveConnectedServer({required ServerInfo server}) async {
    localStorage.write(
        key: StorageConstants.currentVpnSessionFile, value: server.name);
  }

  void setConfigCipherFix(bool value) {
    this.configCipherFix = value;
  }

  @override
  void connect(ServerInfo server) {
    disconnect();

    openvpn.connect(
      _configPatches(server.ovpnConfig),
      server.name,
      // username: username,
      // password: password,
      // bypassPackages: [],
      certIsRequired: true,
    );

    this.server = server;
    saveConnectedServer(server: server);
  }

  @override
  void disconnect() {
    if (server != null) {
      openvpn.disconnect();
      server = null;
    }
  }
}
