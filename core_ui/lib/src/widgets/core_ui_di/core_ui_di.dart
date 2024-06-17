import 'package:core/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:navigation/app_router/app_router.dart';

class CoreUiDI extends StatelessWidget {
  const CoreUiDI({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: AppLocalization.supportedLocales,
      path: AppLocalization.langsFolderPath,
      fallbackLocale: AppLocalization.fallbackLocale,
      child: Builder(builder: (context) {
        // return MaterialApp(
        return MaterialApp.router(
          // title: LangEN.homeTitle,
          title: 'no title',
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
    );
  }
}
