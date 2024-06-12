import 'package:core/core.dart';
import 'package:get_it/get_it.dart';

import '../config/app_config.dart';

final AppDI appDI = AppDI();
final GetIt appLocator = GetIt.instance;

const String unauthScope = 'unauthScope';

class AppDI {
  static Future<void> initDependencies() async {
    appLocator.registerSingleton<AppConfig>(
      AppConfig(
        flavor: Flavor.canary,
        //TODO: fix hardcoded url
        baseUrl: 'https://www.vpngate.net',
        webSocketUrl: '',
        cachePath: await AppPaths.getCacheDirPath(),
      ),
    );

    // appLocator.registerLazySingleton<OpenVPN>(
    //   () {
    //     final openvpn = OpenVPN();
    //     openvpn.initialize();
    //     return openvpn;
    //   },
    // );
  }
}
