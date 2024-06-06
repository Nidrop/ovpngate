import 'package:domain/models/server_info.dart';

abstract class IRepository {
  // final ApiProvider remoteSource;

  Future<List<ServerInfo>> getServerList({
    bool forceRefresh = false,
    bool getCache = false,
  });
}
