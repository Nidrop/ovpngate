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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServerListCubit(appLocator.get<IRepository>()),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(context.tr(LocaleKeys.common_serverList)),
            actions: [
              (kDebugMode)
                  ? IconButton(
                      onPressed: () => context
                          .read<ServerListCubit>()
                          .getServerList(getCache: true),
                      icon: const Icon(Icons.cached),
                    )
                  : const SizedBox(),
              IconButton(
                onPressed: () => context
                    .read<ServerListCubit>()
                    .getServerList(forceRefresh: true),
                icon: const Icon(Icons.refresh),
              ),
              IconButton(
                onPressed: context.read<ServerListCubit>().openSettings,
                icon: const Icon(Icons.settings),
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
                    final server = servers[index];
                    return ServerListItem(
                      server: ServerInfo(
                        countryShort: server.countryShort,
                        speed: server.speed,
                        sessions: server.sessions,
                        uptime: server.uptime,
                        name: server.name,
                        ovpnConfig: server.ovpnConfig,
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
