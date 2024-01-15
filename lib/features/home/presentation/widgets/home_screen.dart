import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(LangEN.connectedTo),
                if (connectedServer.isConnected)
                  Text(connectedServer.server!.name)
                else if (connectedServer.isLoading)
                  const CircularProgressIndicator()
                else
                  const Text(LangEN.notConnected)
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: openServerList,
                  child: const Text(LangEN.connect),
                ),
                ElevatedButton(
                  onPressed: openServerList,
                  child: const Text(LangEN.list),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
