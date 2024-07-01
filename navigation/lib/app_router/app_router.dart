import 'package:auto_route/auto_route.dart';
import 'package:domain/models/server_info.dart';
import 'package:flutter/material.dart';
import 'package:navigation/app_router/splash_guard.dart';
import 'package:server_info/server_info.dart';
import 'package:server_list/server_list.dart';
import 'package:settings/settings.dart';
import 'package:splash/splash.dart';

part 'app_router.gr.dart';

enum AppRoutes {
  splash(path: '/'),
  serverList(path: '/list'),
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
    SplashModule,
  ],
  replaceInRouteName: 'Form,Screen,Route',
)
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          path: AppRoutes.splash.path,
          initial: true,
          guards: [SplashGuard()],
        ),
        AutoRoute(
          page: ServerListRoute.page,
          path: AppRoutes.serverList.path,
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

  // TODO(Karatysh): remove context use appRouter to navigation 
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
      case AppRoutes.settings:
        context.router.push(const SettingsRoute());
      default:
    }
  }
}
