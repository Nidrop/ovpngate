import 'package:flutter/material.dart';
import 'package:server_list_screen/server_list_screen.dart';
import 'package:core/core.dart';

void main() {
  _setupDI();
  runApp(const ServerListScreen());
}

void _setupDI() {
  appLocator.pushNewScope(
    scopeName: unauthScope,
    init: (_) {
      AppDI.initDependencies();
    },
  );
}
