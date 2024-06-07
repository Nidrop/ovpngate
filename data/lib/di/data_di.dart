import 'package:core/config/app_config.dart';
import 'package:core/config/network/dio_config.dart';

import 'package:core/di/app_di.dart';
import 'package:data/repositories/vpngate_repository.dart';
import 'package:domain/repositories/i_repository.dart';

import '../errors/error_handler.dart';
import '../providers/api_provider.dart';

final DataDI dataDI = DataDI();

class DataDI {
  void initDependencies() {
    _initDio();
    _initApi();
  }

  void _initDio() async {
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

    appLocator.registerLazySingleton<IRepository>(
        () => VpngateRepository(remoteSource: appLocator.get<ApiProvider>()));
  }
}
