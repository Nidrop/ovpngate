import 'package:ovpngate/core/domain/entity/server_info.dart';

class ConnectedServerState {
  final ServerInfo? server;
  final bool isConnected;
  final bool isLoading;

  ConnectedServerState({
    this.server,
    this.isConnected = false,
    this.isLoading = false,
  });
}
