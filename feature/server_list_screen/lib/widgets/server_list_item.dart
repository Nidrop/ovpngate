import 'package:core/localization/generated/locale_keys.g.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/models/server_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:server_info_screen/server_info_screen.dart';
import 'package:easy_localization/easy_localization.dart';

class ServerListItem extends StatelessWidget {
  final ServerInfo server;

  const ServerListItem({super.key, required this.server});

  void connect(BuildContext context) {
    // Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ServerInfoScreen(
                  selectedServer: server,
                )));
    // context.router.push(ServerInfoRoute());
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(server.countryShort),
      title: Text(server.name),
      subtitle: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text('${server.sessions} ${LangEN.sessions}'),
          Text('${server.sessions} ${context.tr(LocaleKeys.common_sessions)}'),
          SizedBox(
            width: 20,
          ),
          // Text('${server.uptime} ${LangEN.days}'),
          Text('${server.uptime} ${context.tr(LocaleKeys.common_days)}'),
        ],
      ),
      // trailing: Text('${server.speed} ${LangEN.mbps}'),
      trailing: Text('${server.speed} ${context.tr(LocaleKeys.common_mbps)}'),
      onTap: () => connect(context),
    );
  }
}
