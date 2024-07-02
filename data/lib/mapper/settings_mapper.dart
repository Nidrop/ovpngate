import 'package:domain/models/settings.dart';

abstract class SettingsMapper {
  static Map<String, dynamic> settingsToJson(Settings settings) {
    return <String, dynamic>{
      "themeMode": settings.themeMode.index,
      "fetchMode": settings.fetchMode.index,
      "currentUrl": settings.currentUrl,
      "urls": settings.urls,
    };
  }

  static Settings jsonToSettings(Map<String, dynamic> json) {
    return Settings(
      themeMode: EnThemeMode.values[json["themeMode"]],
      fetchMode: FetchMode.values[json["fetchMode"]],
      urls: List<String>.from(json["urls"]),
      currentUrl: json["currentUrl"],
    );
  }
}
