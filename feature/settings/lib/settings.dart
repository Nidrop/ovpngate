library settings;

import 'package:core/core.dart';
import 'package:navigation/navigation.dart';

import 'settings.gm.dart';
export 'settings.gm.dart';

@AutoRouterConfig.module(replaceInRouteName: 'Screen|Form|Step,Route')
class SettingsModule extends $SettingsModule {}
