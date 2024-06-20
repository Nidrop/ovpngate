import 'package:core/core.dart';
import 'package:core/localization/generated/locale_keys.g.dart';
import 'package:domain/models/server_info.dart';
import 'package:domain/repositories/i_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:server_list/bloc/server_list_cubit.dart';
import 'package:server_list/bloc/server_list_state.dart';
import 'package:navigation/navigation.dart';
import 'package:server_list/widgets/server_list_item.dart';

@RoutePage()
class ServerListScreen extends StatelessWidget {
  const ServerListScreen({super.key});

  void refreshList(BuildContext context, {bool getCache = false}) {
    if (getCache) {
      context.read<ServerListCubit>().getServerList(getCache: true);
      return;
    }
    context.read<ServerListCubit>().getServerList(forceRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServerListCubit(appLocator.get<IRepository>()),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            // title: const Text(LangEN.serverListTitle),
            title: Text(context.tr(LocaleKeys.common_serverList)),
            actions: [
              (kDebugMode)
                  ? IconButton(
                      onPressed: () {
                        //get cached list
                        refreshList(context, getCache: true);
                      },
                      icon: const Icon(Icons.cached),
                    )
                  : const SizedBox(),
              IconButton(
                onPressed: () => refreshList(context),
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          body: BlocBuilder<ServerListCubit, ServerListState>(
              builder: (context, state) {
            return switch (state) {
              ServerListInit() => const SizedBox(),
              ServerListLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              ServerListError(error: final error) => Center(
                  child: Text(error),
                ),
              ServerListLoaded(servers: final servers) => ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return ServerListItem(
                      server: ServerInfo(
                        countryShort: servers[index].countryShort,
                        speed: servers[index].speed,
                        sessions: servers[index].sessions,
                        uptime: servers[index].uptime,
                        name: servers[index].name,
                        ovpnConfig: servers[index].ovpnConfig,
                      ),
                    );
                  },
                  itemCount: servers.length,
                ),
            };
          }),
        );
      }),
    );
  }
}
