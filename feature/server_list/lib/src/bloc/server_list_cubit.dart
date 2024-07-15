import 'package:domain/models/server_info.dart';
import 'package:domain/repositories/i_repository.dart';
import 'package:core/core.dart';
import 'package:navigation/app_router/app_router.dart';
import 'package:server_list/src/bloc/server_list_state.dart';

class ServerListCubit extends Cubit<ServerListState> {
  final IRepository repository;

  ServerListCubit(this.repository) : super(ServerListInit()) {
    getServerList();
  }

  Future<void> getServerList({
    bool forceRefresh = false,
    bool getCache = false,
  }) async {
    emit(ServerListLoading());
    try {
      final servers = await repository.getServerList(
          forceRefresh: forceRefresh, getCache: getCache);

      emit(ServerListLoaded(servers: servers));
    } on Exception catch (e) {
      emit(ServerListError(error: e.toString()));
    }
  }

  void openSettings() {
    AppRouter.pushNamedCustom(
      route: AppRoutes.settings,
    );
  }

  void openServerInfo(ServerInfo server) {
    AppRouter.pushNamedCustom(
      route: AppRoutes.serverInfo,
      obj: server,
    );
  }
}
