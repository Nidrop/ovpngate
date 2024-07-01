import 'package:data/repositories/config_repository.dart';
import 'package:domain/models/settings.dart';
import 'package:domain/repositories/i_settings_service.dart';

class SettingsService implements ISettingsService {
  final ConfigRepository repository;

  @override
  Settings settings;

  SettingsService({
    required this.repository,
    required this.settings,
  });

  @override
  Settings loadSettings() {
    // TODO: implement getSettings
    throw UnimplementedError();
  }

  @override
  void saveSettings(Settings s) {
    // TODO: implement saveSettings
  }
}
