import 'package:domain/models/settings.dart';
import 'package:flutter/material.dart';

abstract class EnThemeModeMapper {
  static ThemeMode enthememodeToThememode(EnThemeMode themeMode) {
    return ThemeMode.values[themeMode.index];
  }
}
