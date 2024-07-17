import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:domain/models/server_info.dart';
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

  static void pushNamedCustom({
    required AppRoutes route,
    Object? obj,
  }) {
    final router = appLocator.get<AppRouter>();
    switch (route) {
      case AppRoutes.serverList:
        router.push(const ServerListRoute());
      case AppRoutes.serverInfo:
        if (obj is ServerInfo) {
          router.push(ServerInfoRoute(selectedServer: obj));
        }
      case AppRoutes.settings:
        router.push(const SettingsRoute());
      default:
    }
  }
}
