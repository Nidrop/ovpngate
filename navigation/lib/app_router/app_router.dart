import 'package:auto_route/auto_route.dart';
import 'package:domain/models/server_info.dart';
import 'package:flutter/material.dart';
import 'package:server_info/server_info.dart';
import 'package:server_list/server_list.dart';
import 'package:settings/settings.dart';

part 'app_router.gr.dart';

enum AppRoutes {
  serverList(path: '/'),
  serverInfo(path: '/info'),
  settings(path: '/settings');

  final String path;

  const AppRoutes({required this.path});
}

@AutoRouterConfig(
  modules: <Type>[
    ServerListModule,
    ServerInfoModule,
    SettingsModule,
  ],
  replaceInRouteName: 'Form,Screen,Route',
)
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: ServerListRoute.page,
          path: AppRoutes.serverList.path,
          initial: true,
        ),
        AutoRoute(
          page: ServerInfoRoute.page,
          path: AppRoutes.serverInfo.path,
        ),
        AutoRoute(
          page: SettingsRoute.page,
          path: AppRoutes.settings.path,
        ),
      ];

  static void pushNamedCustom({
    required AppRoutes route,
    Object? obj,
    required BuildContext context,
  }) {
    switch (route) {
      case AppRoutes.serverList:
        context.router.push(const ServerListRoute());
      case AppRoutes.serverInfo:
        context.router.push(ServerInfoRoute(
            selectedServer: (obj is ServerInfo)
                ? obj
                : throw Exception('argument obj is not ServerInfo instance')));
        break;
      case AppRoutes.settings:
        context.router.push(const SettingsRoute());
      default:
    }
  }
}
