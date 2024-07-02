import 'dart:convert';

import 'package:core/constants/storage_constants.dart';
import 'package:core/logger/logger.dart';
import 'package:data/data.dart';
import 'package:data/mapper/settings_mapper.dart';
import 'package:domain/models/server_info.dart';
import 'package:domain/models/settings.dart';

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

  Future<void> saveSettings({required Settings settings}) async {
    localStorage.write(
        key: StorageConstants.settingsFile,
        value: jsonEncode(SettingsMapper.settingsToJson(settings)));
  }

  Future<Settings?> readSettings() async {
    final jsonStr = await localStorage.read(StorageConstants.settingsFile);
    if (jsonStr == null) return null;
    try {
      return SettingsMapper.jsonToSettings(jsonDecode(jsonStr));
    } catch (e) {
      AppLogger().debug('error while parsing json config: ${e.toString()}');
      return null;
    }
  }
}
