import 'package:domain/models/server_info.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';

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

  ConnectedServerState copyWith({
    OpenVPN? openvpn,
    ServerInfo? Function()? server,
    VPNStage? vpnstage,
    bool? configCipherFix,
  }) {
    return ConnectedServerState(
      openvpn: openvpn ?? this.openvpn,
      server: server != null ? server() : this.server,
      vpnstage: vpnstage ?? this.vpnstage,
      configCipherFix: configCipherFix ?? this.configCipherFix,
    );
  }
}
