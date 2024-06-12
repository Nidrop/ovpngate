import 'package:core/localization/app_localization.dart';
import 'package:core_ui/src/widgets/core_bloc_di/connected_server_cubit.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:navigation/app_router/app_router.dart';
import 'package:server_list/server_list_screen.dart';

class CoreBlocDI extends StatelessWidget {
  const CoreBlocDI({super.key});

  @override
  Widget build(BuildContext context) {
    return /*RepositoryProvider(
      create: (context) => VpngateRepository(
        remoteSource: VpngateRemoteSource(Dio()),
      ),
      child:*/
        EasyLocalization(
      supportedLocales: AppLocalization.supportedLocales,
      path: AppLocalization.langsFolderPath,
      fallbackLocale: AppLocalization.fallbackLocale,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ConnectedServerCubit(),
          ),
          // BlocProvider(
          //   create: (context) => CurrentThemeCubit(),
          // ),
        ],
        child: Builder(builder: (context) {
          // return MaterialApp(
          return MaterialApp.router(
            // title: LangEN.homeTitle,
            title: 'no title',
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routerDelegate: appLocator.get<AppRouter>().delegate(),
            routeInformationParser:
                appLocator.get<AppRouter>().defaultRouteParser(),
            // builder: (context, child) => child ?? const SizedBox(),
            // home: const ServerListScreen(),
          );
        }),
      ),
    );
  }
}
