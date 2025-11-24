import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovpngate/core/di/di.dart';
import 'package:ovpngate/core/domain/entity/server_info.dart';

class ServerListItem extends ConsumerWidget {
  final ServerInfo server;
  final void Function()? onSelect;

  const ServerListItem({super.key, required this.server, this.onSelect});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(langProvider);

    return ListTile(
      leading: Text(server.countryShort),
      title: Text(server.hostName),
      subtitle: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${server.numVpnSessions} ${lang.sessions}'),
          SizedBox(width: 20),
          Text('${server.uptime} ${lang.days}'),
        ],
      ),
      trailing: Text('${server.speed} ${lang.mbps}'),
      onTap: onSelect,
    );
  }
}
