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
    void refreshList({bool getCache = false}) {
      if (getCache) {
        context.read<ServerListCubit>().getServerList(getCache: true);
        return;
      }
      context.read<ServerListCubit>().getServerList(forceRefresh: true);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(LangEN.serverListTitle),
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
