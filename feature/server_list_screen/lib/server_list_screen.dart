import 'package:core/core.dart';
import 'package:core/localization/generated/locale_keys.g.dart';
import 'package:domain/models/server_info.dart';
import 'package:domain/repositories/i_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:server_list_screen/bloc/server_list_cubit.dart';
import 'package:server_list_screen/widgets/server_list_item.dart';
import 'package:easy_localization/easy_localization.dart';

class ServerListScreen extends StatelessWidget {
  const ServerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void refreshList({bool getCache = false}) {
      if (getCache) {
        context.read<ServerListCubit>().getServerList(getCache: true);
        return;
      }
      context.read<ServerListCubit>().getServerList(forceRefresh: true);
    }

    return BlocDI(
      child: Scaffold(
        appBar: AppBar(
          // title: const Text(LangEN.serverListTitle),
          title: Builder(builder: (context) {
            return Text(context.tr(LocaleKeys.common_oVPNGate));
          }),
          actions: [
            (kDebugMode)
                ? IconButton(
                    onPressed: () {
                      //get cached list
                      refreshList(getCache: true);
                    },
                    icon: const Icon(Icons.cached),
                  )
                : const SizedBox(),
            IconButton(
              onPressed: refreshList,
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: Text(
            'F') /*BlocBuilder<ServerListCubit, Future<List<ServerInfo>>>(
            builder: (context, state) {
          return FutureBuilder(
              future: state,
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return ServerListItem(
                        server: ServerInfo(
                          countryShort: snapshot.data![index].countryShort,
                          speed: snapshot.data![index].speed,
                          sessions: snapshot.data![index].sessions,
                          uptime: snapshot.data![index].uptime ,
                          name: snapshot.data![index].name,
                          ovpnConfig: snapshot.data![index].ovpnConfig,
                        ),
                      );
                    },
                    itemCount: snapshot.data!.length,
                  );
                } else if (snapshot.hasError) {
                  return Text('ERROR: ${snapshot.error}');
                } else {
                  return const Text('None');
                }
              });
        })*/
        ,
      ),
    );
  }
}

//TODO: move outside
class BlocDI extends StatelessWidget {
  const BlocDI({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return /*RepositoryProvider(
      create: (context) => VpngateRepository(
        remoteSource: VpngateRemoteSource(Dio()),
      ),
      child:*/
        MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ServerListCubit(appLocator.get<IRepository>()),
        ),
        // BlocProvider(
        //   create: (context) => ConnectedServerCubit(),
        // ),
        // BlocProvider(
        //   create: (context) => CurrentThemeCubit(),
        // ),
      ],
      child: //BlocBuilder<CurrentThemeCubit, ThemeMode>(
          // builder: (context, state) =>
          MaterialApp(
        // title: LangEN.homeTitle,
        title: 'no title',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
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
        home: child,
      ),
      // ),
      // ),
    );
  }
}
