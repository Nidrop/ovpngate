import 'package:domain/models/settings.dart';

abstract class ISettingsService {
  Settings get settings;

  Future<Settings> loadSettings();
  Future<void> saveSettings(Settings settings);
}
