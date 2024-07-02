import 'package:core/core.dart';
import 'package:data/repositories/config_repository.dart';
import 'package:domain/models/settings.dart';
import 'package:domain/repositories/i_settings_service.dart';

class SettingsService implements ISettingsService {
  final ConfigRepository repository;

  @override
  late Settings settings;

  SettingsService({
    required this.repository,
  });

  Future<void> initialize() async {
    await loadSettings();
  }

  @override
  Future<Settings> loadSettings() async {
    settings = await repository.readSettings() ??
        Settings(
          urls: ApiConstants.staticMirrorList,
          currentUrl: ApiConstants.staticMirrorList.first,
        );
    return settings;
  }

  @override
  Future<void> saveSettings(Settings settings) async {
    repository.saveSettings(settings: settings);
  }
}
