import 'package:core/core.dart';
import 'package:domain/repositories/i_vpn_service.dart';
import 'package:navigation/navigation.dart';
import 'package:server_info/server_info.dart';
import 'package:server_list/server_list.dart';

class SplashGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final vpn = appLocator.get<IVpnService>();
    if (vpn.server != null) {
      appLocator.get<AppRouter>().replace(const ServerListRoute());
      appLocator
          .get<AppRouter>()
          .push(ServerInfoRoute(selectedServer: vpn.server!));
    } else {
      appLocator.get<AppRouter>().replace(const ServerListRoute());
    }
  }
}
