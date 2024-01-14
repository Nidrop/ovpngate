import 'package:flutter/material.dart';
import 'package:ovpngate/core/lang/lang_en.dart';
import 'package:ovpngate/features/server%20list/presentation/server_list_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
          const Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(LangEN.connectedTo),
                Text(LangEN.notConnected),
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
