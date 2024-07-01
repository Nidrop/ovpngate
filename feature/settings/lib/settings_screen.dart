import 'package:core/core.dart';
import 'package:core/localization/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:settings/widgets/mirror_list_view.dart';
import 'package:settings/widgets/theme_toggle.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr(LocaleKeys.common_settings)),
      ),
      body: Column(
        children: [
          Text('Theme'),
          const SizedBox(
            height: 50,
            child: ThemeToggle(),
          ),
          Text('Fetch'),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('CSV'),
                Switch(value: false, onChanged: (val) {}),
                Text('HTML'),
              ],
            ),
          ),
          Text('Mirrors order'),
          const Flexible(
            child: MirrorListView(),
          ),
        ],
      ),
    );
  }
}
