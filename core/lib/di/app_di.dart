import 'package:data/data.dart';
import 'package:get_it/get_it.dart';

import '../config/app_config.dart';

final AppDI appDI = AppDI();
final GetIt appLocator = GetIt.instance;

const String unauthScope = 'unauthScope';

class AppDI {
  static void initDependencies() {
    appLocator.registerSingleton<AppConfig>(
      AppConfig(
        flavor: Flavor.canary,
        //TODO: fix hardcoded url
        baseUrl: 'https://www.vpngate.net',
        webSocketUrl: '',
      ),
    );

    dataDI.initDependencies();
  }
}
