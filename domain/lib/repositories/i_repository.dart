import 'package:domain/models/server_info.dart';

abstract class IRepository {
  // final ApiProvider remoteSource;

  Future<List<ServerInfo>> getServerList({
    required bool forceRefresh,
    required bool getCache,
  });

  Future<String> getConfig({required String path});
}
