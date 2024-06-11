import 'package:auto_route/auto_route.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        // AutoRoute(page: ServerListRoute.page, initial: true),
        // AutoRoute(page: ServerInfoRoute.page),
      ];
}
