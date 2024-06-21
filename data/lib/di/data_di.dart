import 'package:core/config/app_config.dart';
import 'package:core/config/network/dio_config.dart';

import 'package:core/di/app_di.dart';
import 'package:data/providers/local_data_provider.dart';
import 'package:data/repositories/vpngate_repository.dart';
import 'package:data/repositories/openvpn_service.dart';
import 'package:domain/repositories/i_repository.dart';
import 'package:domain/repositories/i_vpn_service.dart';

import '../errors/error_handler.dart';
import '../providers/api_provider.dart';

final DataDI dataDI = DataDI();

class DataDI {
  void initDependencies() {
    _initDio();
    _initApi();
    _initService();
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
    appLocator.registerLazySingleton<LocalConfigProviderImpl>(
      () => LocalConfigProviderImpl(appConfig: appLocator<AppConfig>()),
    );

    appLocator.registerLazySingleton<IVpnService>(
      () => OpenvpnService(
          localStorage: appLocator.get<LocalConfigProviderImpl>()),
    );
  }
}
