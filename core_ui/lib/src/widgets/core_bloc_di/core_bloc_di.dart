import 'package:core/localization/app_localization.dart';
import 'package:core_ui/src/widgets/core_bloc_di/connected_server_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:navigation/app_router/app_router.dart';
import 'package:server_list_screen/server_list_screen.dart';

class CoreBlocDI extends StatelessWidget {
  CoreBlocDI({super.key});

  final _appRouter = AppRouter();

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
          return MaterialApp(
            // return MaterialApp.router(
            // title: LangEN.homeTitle,
            title: 'no title',
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            // routerConfig: _appRouter.config(),
            home: ServerListScreen(),
            // theme: ThemeData(
            //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            //   useMaterial3: true,
            // ),
            // darkTheme: ThemeData(
            //   colorScheme: ColorScheme.fromSeed(
            //     seedColor: Colors.blue,
            //     brightness: Brightness.dark,
            //   ),
            //   useMaterial3: true,
            // ),
            // themeMode: state,
          );
        }),
        // ),
        // ),
      ),
    );
  }
}
