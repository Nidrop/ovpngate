import 'package:core_ui/core_ui.dart';
import 'package:data/di/data_di.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:navigation/navigation.dart';

// TODO(Kartysh): do you use macos, windows, linux folders? If no, remove them
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await _setupDI();
  runApp(const CoreUiDI());
}

Future<void> _setupDI() async {
  // appLocator.pushNewScope(
  //   scopeName: unauthScope,
  //   init: (_) async {
  //     await AppDI.initDependencies();
  //   },
  // );
  AppDI.initDependencies();
  dataDI.initDependencies();
  setupNavigationDependencies();

  await appLocator.allReady();
}
