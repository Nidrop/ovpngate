import 'package:core_ui/core_ui.dart';
import 'package:data/di/data_di.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:navigation/navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  _setupDI();
  runApp(const CoreUiDI());
}

void _setupDI() {
  appLocator.pushNewScope(
    scopeName: unauthScope,
    init: (_) {
      AppDI.initDependencies();
    },
  );

  dataDI.initDependencies();
  setupNavigationDependencies();
}
