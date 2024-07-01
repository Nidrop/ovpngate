import 'package:core/localization/app_localization.dart';
import 'package:core/localization/generated/locale_keys.g.dart';
import 'package:core_ui/core_ui.dart';
import 'package:core_ui/src/widgets/core_ui_di/en_theme_mode_mapper.dart';
import 'package:domain/models/settings.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:navigation/app_router/app_router.dart';
import 'package:domain/repositories/i_settings_service.dart';

class CoreUiDI extends StatefulWidget {
  const CoreUiDI({super.key});

  @override
  State<CoreUiDI> createState() => _CoreUiDIState();
}

class _CoreUiDIState extends State<CoreUiDI> {
  EnThemeMode tm = appLocator.get<ISettingsService>().settings.themeMode;

  void updateTheme() {
    setState(() {
      tm = appLocator.get<ISettingsService>().settings.themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: AppLocalization.supportedLocales,
      path: AppLocalization.langsFolderPath,
      fallbackLocale: AppLocalization.fallbackLocale,
      child: ThemeInheritedWidget(
        themeMode: EnThemeModeMapper.enthememodeToThememode(tm),
        updateTheme: updateTheme,
        child: Builder(builder: (context) {
          // return MaterialApp(
          return MaterialApp.router(
            title: tr(LocaleKeys.common_oVPNGate),
            theme: lTheme,
            darkTheme: dTheme,
            themeMode: ThemeInheritedWidget.of(context)!.themeMode,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routerDelegate: appLocator.get<AppRouter>().delegate(),
            routeInformationParser:
                appLocator.get<AppRouter>().defaultRouteParser(),
            // builder: (context, child) => child ?? const SizedBox(),
            // home: const ServerListScreen(),
          );
        }),
      ),
    );
  }
}

class ThemeInheritedWidget extends InheritedWidget {
  const ThemeInheritedWidget(
      {super.key,
      required super.child,
      required this.themeMode,
      required this.updateTheme});

  final ThemeMode themeMode;
  final void Function() updateTheme;

  static ThemeInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeInheritedWidget>();
  }

  @override
  bool updateShouldNotify(ThemeInheritedWidget oldWidget) {
    return oldWidget.themeMode != themeMode;
  }
}
