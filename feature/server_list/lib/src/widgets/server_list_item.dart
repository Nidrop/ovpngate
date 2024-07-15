import 'package:core/localization/generated/locale_keys.g.dart';
import 'package:core/core.dart';
import 'package:domain/models/server_info.dart';
import 'package:flutter/material.dart';
import 'package:server_list/src/bloc/server_list_cubit.dart';

class ServerListItem extends StatelessWidget {
  final ServerInfo server;

  const ServerListItem({super.key, required this.server});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(server.countryShort),
      title: Text(server.name),
      subtitle: Row(
        children: [
          Text('${server.sessions} ${context.tr(LocaleKeys.common_sessions)}'),
          SizedBox(
            width: 20,
          ),
          Text('${server.uptime} ${context.tr(LocaleKeys.common_days)}'),
        ],
      ),
      trailing: Text('${server.speed} ${context.tr(LocaleKeys.common_mbps)}'),
      onTap: () => context.read<ServerListCubit>().openServerInfo(server),
    );
  }
}
