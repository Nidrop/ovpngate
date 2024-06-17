import 'package:core/core.dart';
import 'package:domain/models/server_info.dart';

sealed class ServerInfoState {
  final ServerInfo selectedServer;

  ServerInfoState({required this.selectedServer});
}

class SelectedServerState extends ServerInfoState {
  SelectedServerState({
    required super.selectedServer,
  });
}

class ConnectedServerState extends ServerInfoState {
  final ServerInfo connectedServer;
  final VPNStage stage;
  // final VpnStatus status;
  ConnectedServerState({
    required super.selectedServer,
    required this.connectedServer,
    required this.stage,
  });
}
