import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
import 'package:ovpngate/core/lang/lang_en.dart';
import 'package:ovpngate/core/presentation/bloc/connected_server_cubit.dart';
import 'package:ovpngate/features/server%20list/presentation/server_list_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final connectedServer = context.watch<ConnectedServerCubit>().state;

    void openServerList() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ServerListScreen()));
    }

    void connect() {
      if (connectedServer.server == null) {
        openServerList();
        return;
      }

      context.read<ConnectedServerCubit>().connect();
    }

    void disconnect() {
      context.read<ConnectedServerCubit>().disconnect();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(LangEN.homeTitle),
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
                  '${LangEN.vpnServer}:',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                if (connectedServer.server != null)
                  Text(
                    connectedServer.server!.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                else
                  Text(
                    LangEN.notSelected,
                    style: TextStyle(
                        // fontSize: 20,
                        // fontWeight: FontWeight.bold,
                        ),
                  ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '${LangEN.vpnStage}:',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  connectedServer.vpnstage.name,
                  style: TextStyle(
                      // fontSize: 20,
                      // fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Center(
                child: (connectedServer.vpnstage == VPNStage.connected)
                    ? ElevatedButton(
                        onPressed: disconnect,
                        child: const Text(LangEN.disconnect),
                      )
                    : ElevatedButton(
                        onPressed: connect,
                        child: const Text(LangEN.connect),
                      )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openServerList,
        child: const Icon(Icons.list),
      ),
    );
  }
}
