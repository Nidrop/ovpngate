library splash;

import 'package:core/core.dart';
import 'package:navigation/navigation.dart';

import 'splash.gm.dart';
export 'splash.gm.dart';

@AutoRouterConfig.module(replaceInRouteName: 'Screen|Form|Step,Route')
class SplashModule extends $SplashModule {}
