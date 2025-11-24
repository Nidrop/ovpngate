part of 'home_controller.dart';

mixin HomeHandler {
  void selectServerUsecase(WidgetRef ref) async {
    final ServerInfo? server = await Navigator.push(
      ref.context,
      MaterialPageRoute(builder: (context) => const ServerListScreen()),
    );
    if (server != null) {
      ref.read(_serverInfoNotifier.notifier).setServerInfo(server);
    }
  }

  void connectUsecase(WidgetRef ref, {required ServerInfo? server}) async {
    if (server == null) return;

    (await ref.read(
      openvpnServiceProvider.future,
    )).connect(serverName: server.hostName, config: server.vpnConfig);
  }

  void disconnectUsecase(WidgetRef ref) async {
    (await ref.read(openvpnServiceProvider.future)).disconnect();
  }
}
