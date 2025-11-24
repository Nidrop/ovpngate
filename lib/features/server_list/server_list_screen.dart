import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovpngate/core/di/di.dart';
import 'package:ovpngate/core/domain/entity/server_info.dart';
import 'package:ovpngate/features/server_list/controller/server_list_controller.dart';
import 'package:ovpngate/features/server_list/widgets/server_list_item.dart';

class ServerListScreen extends ConsumerWidget
    with ServerListState, ServerListHandler {
  const ServerListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(langProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.serverListTitle),
        actions: [
          (kDebugMode)
              ? IconButton(
                  onPressed: () => getServerListUsecase(ref, getCache: true),
                  icon: const Icon(Icons.cached),
                )
              : const SizedBox(),
          IconButton(
            onPressed: () => getServerListUsecase(ref, forceRefresh: true),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: switch (serverListState(ref)) {
        AsyncLoading<List<ServerInfo>>() => const Center(
          child: CircularProgressIndicator(),
        ),
        AsyncData<List<ServerInfo>>(value: final List<ServerInfo> serverList) =>
          ListView.builder(
            itemCount: serverList.length,
            itemBuilder: (BuildContext context, int index) {
              return ServerListItem(
                server: serverList[index].copyWith(
                  speed: toMegaBytes(serverList[index].speed),
                  uptime: toDays(serverList[index].uptime),
                ),
                onSelect: () =>
                    selectServerUsecase(ref, server: serverList[index]),
              );
            },
          ),
        AsyncError<List<ServerInfo>>(:final error) => Center(
          child: Text(error.toString()),
        ),
      },
    );
  }
}
