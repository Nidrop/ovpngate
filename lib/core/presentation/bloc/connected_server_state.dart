import 'package:openvpn_flutter/openvpn_flutter.dart';
import 'package:ovpngate/core/domain/entity/server_info.dart';

class ConnectedServerState {
  final OpenVPN openvpn;
  final ServerInfo? server;
  final VPNStage vpnstage;
  final bool configCipherFix;

  ConnectedServerState({
    required this.openvpn,
    this.server,
    required this.vpnstage,
    required this.configCipherFix,
  });
}
