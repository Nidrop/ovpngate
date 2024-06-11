import 'package:core/localization/generated/locale_keys.g.dart';
import 'package:domain/models/server_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core_ui/src/widgets/core_bloc_di/connected_server_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
import 'package:auto_route/annotations.dart';

@RoutePage()
class ServerInfoScreen extends StatelessWidget {
  const ServerInfoScreen({super.key, required this.selectedServer});

  final ServerInfo selectedServer;

  @override
  Widget build(BuildContext context) {
    final connectedServer = context.watch<ConnectedServerCubit>().state;
    final t = connectedServer.server == selectedServer;

    void connect() {
      context.read<ConnectedServerCubit>().connect(selectedServer);
    }

    void disconnect() {
      context.read<ConnectedServerCubit>().disconnect();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr(LocaleKeys.common_oVPNGate)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  context.tr(LocaleKeys.common_vpnServer),
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  selectedServer.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (connectedServer.server != null && t)
                  Text(
                    connectedServer.vpnstage.name,
                    style: TextStyle(
                        // fontSize: 20,
                        // fontWeight: FontWeight.bold,
                        ),
                  )
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Center(
              child: (connectedServer.server == null || !t)
                  ? FilledButton(
                      onPressed: connect,
                      child: Text(context.tr(LocaleKeys.common_connect)),
                    )
                  : FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                      onPressed: disconnect,
                      child: Text(context.tr(LocaleKeys.common_disconnect)),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
