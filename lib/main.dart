import 'package:core/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:server_list_screen/server_list_screen.dart';
import 'package:core/core.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  _setupDI();
  runApp(EasyLocalization(
    supportedLocales: AppLocalization.supportedLocales,
    path: AppLocalization.langsFolderPath,
    fallbackLocale: AppLocalization.fallbackLocale,
    child: const ServerListScreen(),
  ));
}

void _setupDI() {
  appLocator.pushNewScope(
    scopeName: unauthScope,
    init: (_) {
      AppDI.initDependencies();
    },
  );
}
