library server_list;

import 'package:core/core.dart';
import 'package:navigation/navigation.dart';

import 'server_list.gm.dart';
export 'server_list.gm.dart';

@AutoRouterConfig.module(replaceInRouteName: 'Screen|Form|Step,Route')
class ServerListModule extends $ServerListModule {}
