import 'package:domain/models/settings.dart';

abstract class ISettingsService {
  Settings get settings;

  Settings loadSettings();
  void saveSettings(Settings s);
}
