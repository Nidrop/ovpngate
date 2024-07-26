import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/models/settings.dart';
import 'package:domain/repositories/i_settings_service.dart';
import 'package:flutter/material.dart';
import 'package:settings/src/bloc/settings_cubit.dart';

class ThemeToggle extends StatelessWidget {
  final EnThemeMode themeMode;
  const ThemeToggle({
    required this.themeMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: [
        for (final element in EnThemeMode.values)
          element == themeMode ? true : false
      ],
      onPressed: (int index) =>
          context.read<SettingsCubit>().changeTheme(index),
      children: const [
        Icon(Icons.phone_android),
        Icon(Icons.light_mode),
        Icon(Icons.dark_mode),
      ],
    );
  }
}
