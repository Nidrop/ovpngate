import 'package:core/core.dart';
import 'package:navigation/app_router/app_router.dart';

// TODO(Karatysh): you never use it
void setupNavigationDependencies() {
  appLocator.registerSingleton<AppRouter>(AppRouter());
}
