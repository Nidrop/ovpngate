import 'dart:async';

import 'package:core/core.dart';
import 'package:data/mapper/openvpn_mapper.dart';
import 'package:domain/models/server_info.dart';
import 'package:domain/repositories/i_vpn_service.dart';

class OpenvpnService implements IVpnService {
  @override
  ServerInfo? server;
  @override
  EnVPNStage vpnstage;
  @override
  StreamController stageSC = StreamController<EnVPNStage>.broadcast();

  @override
  Stream get stageStream => stageSC.stream;

  late final OpenVPN openvpn;
  bool configCipherFix;

  OpenvpnService({
    this.configCipherFix = true,
    this.vpnstage = EnVPNStage.unknown,
  }) {
    openvpn = OpenVPN(
        onVpnStageChanged: _onVpnStageChanged,
        onVpnStatusChanged: _onVpnStatusChanged);
    openvpn.initialize(
      localizedDescription: 'oVPNGate',
    );
    openvpn.stage().then((stage) {
      vpnstage = OpenvpnMapper.vpnstageToEnvpnstage(stage);
      server = (stage != VPNStage.disconnected)
          //TODO load server
          ? ServerInfo(
              speed: -1,
              countryShort: "",
              sessions: -1,
              uptime: -1,
              name: "",
              ovpnConfig: "")
          : null;
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

    //TODO save server
    this.server = server;
  }

  @override
  void disconnect() {
    if (server != null) {
      openvpn.disconnect();
      server = null;
    }
  }
}
