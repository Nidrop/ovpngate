import 'package:auto_route/auto_route.dart';
import 'package:server_info/server_info.dart';
import 'package:server_list/server_list.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  modules: <Type>[
    ServerListModule,
    ServerInfoModule,
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
          path: '/',
          initial: true,
        ),
        AutoRoute(
          page: ServerInfoRoute.page,
          path: '/info',
        ),
      ];
}
