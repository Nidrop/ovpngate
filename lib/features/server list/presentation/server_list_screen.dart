import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovpngate/core/domain/entity/server_info.dart';
import 'package:ovpngate/core/lang/lang_en.dart';
import 'package:ovpngate/features/server%20list/presentation/bloc/server_list_cubit.dart';
import 'package:ovpngate/features/server%20list/presentation/widgets/server_list_item.dart';

class ServerListScreen extends StatelessWidget {
  const ServerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO refactor
    void refreshList({bool forceRefresh = false}) {
      context.read<ServerListCubit>().getServerList(forceRefresh: forceRefresh);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(LangEN.serverListTitle),
        actions: [
          (!kReleaseMode)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        //debug refresh from cache
                        refreshList(forceRefresh: false);
                      },
                      icon: const Icon(Icons.arrow_upward),
                    ),
                    IconButton(
                      onPressed: () => refreshList(forceRefresh: true),
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                )
              : IconButton(
                  onPressed: refreshList,
                  icon: const Icon(Icons.refresh),
                ),
        ],
      ),
      body: FutureBuilder(
          future: context.watch<ServerListCubit>().state,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ServerListItem(
                    server: ServerInfo(
                      countryShort: snapshot.data![index].countryShort,
                      speed:
                          (snapshot.data![index].speed / 1000 / 1000).round(),
                      sessions: snapshot.data![index].sessions,
                      uptime:
                          (snapshot.data![index].uptime / 1000 / 60 / 60 / 24)
                              .round(),
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
          }),
    );
  }
}
