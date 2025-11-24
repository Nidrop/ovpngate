part of 'server_list_controller.dart';

mixin ServerListState {
  AsyncValue<List<ServerInfo>> serverListState(WidgetRef ref) =>
      ref.watch(_serverListAsyncNotifier);

  int toMegaBytes(int bytes) {
    return (bytes / 1000 / 1000).round();
  }

  int toDays(int milliseconds) {
    return (milliseconds / 1000 / 60 / 60 / 24).round();
  }
}
