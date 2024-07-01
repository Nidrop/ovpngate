import 'package:core/config/app_config.dart';
import 'package:core/config/network/dio_config.dart';
import 'package:core/core.dart';

import 'package:core/di/app_di.dart';
import 'package:data/providers/local_data_provider.dart';
import 'package:data/repositories/config_repository.dart';
import 'package:data/repositories/settings_service.dart';
import 'package:data/repositories/vpngate_repository.dart';
import 'package:data/repositories/openvpn_service.dart';
import 'package:domain/models/settings.dart';
import 'package:domain/repositories/i_repository.dart';
import 'package:domain/repositories/i_settings_service.dart';
import 'package:domain/repositories/i_vpn_service.dart';

import '../errors/error_handler.dart';
import '../providers/api_provider.dart';

final DataDI dataDI = DataDI();

class DataDI {
  void initDependencies() {
    _initDio();
    _initApi();
    _initService();
    _initSetting();
  }

  void _initDio() {
    appLocator.registerLazySingleton<DioConfig>(
      () => DioConfig(
        appConfig: appLocator<AppConfig>(),
      ),
    );
  }

  void _initApi() {
    appLocator.registerLazySingleton<ErrorHandler>(
      ErrorHandler.new,
    );

    appLocator.registerLazySingleton<ApiProvider>(
      () => ApiProvider(
        appLocator<DioConfig>().dio,
      ),
    );

    appLocator.registerLazySingleton<LocalCacheProviderImpl>(
      () => LocalCacheProviderImpl(appConfig: appLocator<AppConfig>()),
    );

    appLocator.registerLazySingleton<IRepository>(
      () => VpngateRepository(
          remoteProvider: appLocator.get<ApiProvider>(),
          localProvider: appLocator.get<LocalCacheProviderImpl>()),
    );
  }

  void _initService() {
    appLocator.registerSingletonAsync<LocalConfigProviderImpl>(
      () async => LocalConfigProviderImpl(appConfig: appLocator<AppConfig>()),
      dependsOn: [AppConfig],
    );

    appLocator.registerSingletonAsync<ConfigRepository>(
      () async => ConfigRepository(
          localStorage: appLocator.get<LocalConfigProviderImpl>()),
      dependsOn: [LocalConfigProviderImpl],
    );

    appLocator.registerSingletonAsync<IVpnService>(() async {
      final openvpnService =
          OpenvpnService(localRepository: appLocator.get<ConfigRepository>());
      await openvpnService.initialize();
      return openvpnService;
    }, dependsOn: [ConfigRepository]);
  }

  void _initSetting() {
    appLocator.registerSingletonAsync<ISettingsService>(
      () async => SettingsService(
        repository: appLocator.get<ConfigRepository>(),
        settings: Settings(
          urls: ApiConstants.staticMirrorList,
          currentUrl: ApiConstants.staticMirrorList.first,
        ),
      ),
      dependsOn: [ConfigRepository],
    );
  }
}
