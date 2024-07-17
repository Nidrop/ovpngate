import 'package:domain/models/server_info.dart';

sealed class ServerListState {}

class ServerListInit implements ServerListState {}

class ServerListLoading implements ServerListState {}

class ServerListError implements ServerListState {
  ServerListError({required this.error});
  final String error;
}

class ServerListLoaded implements ServerListState {
  ServerListLoaded({required this.servers});
  final List<ServerInfo> servers;
}
