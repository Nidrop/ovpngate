import 'package:domain/models/settings.dart';

abstract class ISettingsService {
  Settings get settings;
  set settings(Settings s) => s;

  Future<Settings> loadSettings();
  Future<void> saveSettings();
}
