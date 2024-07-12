import 'package:core/localization/generated/locale_keys.g.dart';
import 'package:core/core.dart';
import 'package:domain/models/server_info.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

class ServerListItem extends StatelessWidget {
  final ServerInfo server;

  const ServerListItem({super.key, required this.server});

  void select() {
    AppRouter.pushNamedCustom(
      route: AppRoutes.serverInfo,
      obj: server,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(server.countryShort),
      title: Text(server.name),
      subtitle: Row(
        //TODO(Karatysh): remove all comments
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text('${server.sessions} ${LangEN.sessions}'),
          Text('${server.sessions} ${context.tr(LocaleKeys.common_sessions)}'),
          //TODO(Karatysh): nit: remove comma here
          SizedBox(
            width: 20,
          ),
          // Text('${server.uptime} ${LangEN.days}'),
          Text('${server.uptime} ${context.tr(LocaleKeys.common_days)}'),
        ],
      ),
      // trailing: Text('${server.speed} ${LangEN.mbps}'),
      trailing: Text('${server.speed} ${context.tr(LocaleKeys.common_mbps)}'),
      onTap: select,
    );
  }
}
