import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentThemeCubit extends Cubit<ThemeMode> {
  CurrentThemeCubit() : super(ThemeMode.system);

  void toggleMode() {
    late ThemeMode res;
    switch (state) {
      case ThemeMode.light:
        res = ThemeMode.dark;
      case ThemeMode.dark:
        res = ThemeMode.system;
      case ThemeMode.system:
        res = ThemeMode.light;
    }
    emit(res);
  }
}
