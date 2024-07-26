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
  int index;
  List<String> urls;

  Settings({
    this.themeMode = EnThemeMode.system,
    this.fetchMode = FetchMode.csv,
    required this.urls,
    required this.index,
  });

  Settings copy() {
    return Settings(
      themeMode: this.themeMode,
      fetchMode: this.fetchMode,
      urls: [...this.urls],
      index: this.index,
    );
  }

  Settings copyWith({
    EnThemeMode? themeMode,
    FetchMode? fetchMode,
    int? index,
    List<String>? urls,
  }) {
    return Settings(
      themeMode: themeMode ?? this.themeMode,
      fetchMode: fetchMode ?? this.fetchMode,
      urls: urls ?? this.urls,
      index: index ?? this.index,
    );
  }
}
