import 'package:domain/models/server_info.dart';
import 'package:domain/repositories/i_vpn_service.dart';

sealed class ServerInfoState {
  final ServerInfo selectedServer;

  ServerInfoState({required this.selectedServer});
}

class SelectedServerState extends ServerInfoState {
  SelectedServerState({
    required super.selectedServer,
  });
}

class DownloadingServerInfoState extends ServerInfoState {
  DownloadingServerInfoState({
    required super.selectedServer,
  });
}

class DisabledServerState extends ServerInfoState {
  DisabledServerState({
    required super.selectedServer,
  });
}

class ErrorServerState extends ServerInfoState {
  final String? error;
  ErrorServerState({
    required super.selectedServer,
    required this.error,
  });
}

class ConnectedServerState extends ServerInfoState {
  final ServerInfo connectedServer;
  final EnVPNStage stage;
  // final VpnStatus status;
  ConnectedServerState({
    required super.selectedServer,
    required this.connectedServer,
    required this.stage,
  });
}
