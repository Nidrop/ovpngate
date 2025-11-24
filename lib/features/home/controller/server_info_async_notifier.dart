part of 'home_controller.dart';

class ServerInfoAsyncNotifier extends Notifier<ServerInfo?> {
  @override
  ServerInfo? build() {
    return ref
        .watch(openvpnServiceProvider)
        .maybeWhen(
          data: (OpenvpnService openVpnService) {
            if (openVpnService.serverName != null) {
              return ServerInfo.empty().copyWith(
                hostName: openVpnService.serverName,
              );
            }
            return null;
          },
          orElse: () => null,
        );
  }

  void setServerInfo(ServerInfo? server) {
    state = server;
  }
}

final _serverInfoNotifier = NotifierProvider(ServerInfoAsyncNotifier.new);
