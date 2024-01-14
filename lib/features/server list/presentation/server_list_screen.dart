import 'package:flutter/material.dart';
import 'package:ovpngate/core/lang/lang_en.dart';
import 'package:ovpngate/features/server%20list/presentation/widgets/server_list_item.dart';

class ServerListScreen extends StatelessWidget {
  const ServerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LangEN.serverListTitle),
      ),
      body: ListView(
        children: [
          ServerListItem(),
        ],
      ),
    );
  }
}
