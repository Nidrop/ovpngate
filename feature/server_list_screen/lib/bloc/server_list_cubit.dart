import 'package:domain/models/server_info.dart';
import 'package:domain/repositories/i_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServerListCubit extends Cubit<Future<List<ServerInfo>>> {
  final IRepository repository;

  ServerListCubit(this.repository)
      : super(repository.getServerList(forceRefresh: false));

  void getServerList({
    bool forceRefresh = false,
    bool getCache = false,
  }) {
    emit(repository.getServerList(
      forceRefresh: forceRefresh,
      getCache: getCache,
    ));
  }
}
