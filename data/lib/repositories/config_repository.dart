import 'package:core/constants/storage_constants.dart';
import 'package:data/data.dart';
import 'package:domain/models/server_info.dart';

class ConfigRepository {
  final LocalDataProvider localStorage;

  ConfigRepository({required this.localStorage});

  Future<void> saveConnectedServer({required ServerInfo server}) async {
    localStorage.write(
        key: StorageConstants.currentVpnSessionFile, value: server.name);
  }

  Future<ServerInfo?> readLastConnectedServer() async {
    final server =
        await localStorage.read(StorageConstants.currentVpnSessionFile);
    if (server == null) return null;
    return ServerInfo(
      speed: -1,
      countryShort: '',
      sessions: -1,
      uptime: -1,
      name: server,
      ovpnConfig: '',
    );
  }
}
