import 'package:core/core.dart';
import 'package:get_it/get_it.dart';

import '../config/app_config.dart';

final AppDI appDI = AppDI();
final GetIt appLocator = GetIt.instance;

const String unauthScope = 'unauthScope';

class AppDI {
  static void initDependencies() {
    appLocator.registerSingletonAsync<AppConfig>(
      () async => AppConfig(
        flavor: Flavor.canary,
        baseUrl: 'https://www.vpngate.net',
        cachePath: await AppPaths.getCacheDirPath(),
        configPath: await AppPaths.getConfigDirPath(),
      ),
    );
  }
}
