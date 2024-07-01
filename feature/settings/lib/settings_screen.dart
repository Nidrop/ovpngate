import 'package:core/core.dart';
import 'package:core/localization/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

// TODO(Karatysh): create src folder and put inside all files except server_list and server_list.gm. do this for all modules
@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr(LocaleKeys.common_settings)),
      ),
      body: ListView(
        children: [
          Text('element'),
        ],
      ),
    );
  }
}
