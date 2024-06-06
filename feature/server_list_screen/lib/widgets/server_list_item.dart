import 'package:domain/models/server_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServerListItem extends StatelessWidget {
  final ServerInfo server;

  const ServerListItem({super.key, required this.server});

  void connect(BuildContext context) {
    // context.read<ConnectedServerCubit>().setServer(server);
    // Navigator.pop(context);
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
          Text('${server.sessions} ${'sessions'}'),
          SizedBox(
            width: 20,
          ),
          // Text('${server.uptime} ${LangEN.days}'),
          Text('${server.uptime} ${'days'}'),
        ],
      ),
      // trailing: Text('${server.speed} ${LangEN.mbps}'),
      trailing: Text('${server.speed} ${'mbps'}'),
      onTap: () => connect(context),
    );
  }
}
