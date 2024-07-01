import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/models/settings.dart';
import 'package:domain/repositories/i_settings_service.dart';
import 'package:flutter/material.dart';

class ThemeToggle extends StatefulWidget {
  const ThemeToggle({
    super.key,
  });

  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  final _isSelected = [false, false, false];

  @override
  void initState() {
    super.initState();

    _isSelected[appLocator.get<ISettingsService>().settings.themeMode.index] =
        true;
  }

  void changeTheme(BuildContext context, int index) {
    setState(() {
      for (int buttonIndex = 0;
          buttonIndex < _isSelected.length;
          buttonIndex++) {
        if (buttonIndex == index) {
          _isSelected[buttonIndex] = true;
          appLocator.get<ISettingsService>().settings.themeMode =
              EnThemeMode.values[index];
          ThemeInheritedWidget.of(context)!.updateTheme();
        } else {
          _isSelected[buttonIndex] = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: _isSelected,
      onPressed: (int index) => changeTheme(context, index),
      children: const [
        Icon(Icons.phone_android),
        Icon(Icons.light_mode),
        Icon(Icons.dark_mode),
      ],
    );
  }
}
