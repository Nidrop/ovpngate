enum EnThemeMode {
  system,
  light,
  dark,
}

enum FetchMode {
  csv,
  html,
}

class Settings {
  EnThemeMode themeMode;
  FetchMode fetchMode;
  String currentUrl;
  List<String> urls;

  Settings({
    this.themeMode = EnThemeMode.system,
    this.fetchMode = FetchMode.csv,
    required this.urls,
    required this.currentUrl,
  });
}
