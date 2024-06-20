import 'package:domain/repositories/i_repository.dart';
import 'package:core/core.dart';
import 'package:server_list/bloc/server_list_state.dart';

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
}
