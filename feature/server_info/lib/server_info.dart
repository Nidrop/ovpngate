library server_info;

import 'package:core/core.dart';
import 'package:navigation/navigation.dart';

import 'server_info.gm.dart';
export 'server_info.gm.dart';

@AutoRouterConfig.module(replaceInRouteName: 'Screen|Form|Step,Route')
class ServerInfoModule extends $ServerInfoModule {}
