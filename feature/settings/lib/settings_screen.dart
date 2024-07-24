import 'package:core/core.dart';
import 'package:core/localization/generated/locale_keys.g.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/models/settings.dart';
import 'package:domain/repositories/i_settings_service.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:settings/bloc/settings_cubit.dart';
import 'package:settings/widgets/fetch_switch.dart';
import 'package:settings/widgets/mirror_list_view.dart';
import 'package:settings/widgets/mirror_text_field.dart';
import 'package:settings/widgets/theme_toggle.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, this.settingsInit});
  final Settings? settingsInit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SettingsCubit(
            settingsInit ?? appLocator.get<ISettingsService>().settings.copy()),
        child: BlocBuilder<SettingsCubit, Settings>(
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: Text(context.tr(LocaleKeys.common_settings)),
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<SettingsCubit>().saveSettings();
                    ThemeInheritedWidget.of(context)!.updateTheme();
                  },
                  icon: const Icon(Icons.check),
                ),
              ],
            ),
            body: ListView(
              children: [
                Text('Theme'),
                SizedBox(
                  height: 50,
                  child: ThemeToggle(themeMode: state.themeMode),
                ),
                Text('Fetch'),
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('CSV'),
                      FetchSwitch(fetchMode: state.fetchMode),
                      Text('HTML'),
                    ],
                  ),
                ),
                if (state.fetchMode == FetchMode.html) ...[
                  Divider(),
                  Text('Add mirror:'),
                  MirrorTextField(
                    onSubmitted: (url) {
                      context.read<SettingsCubit>().addMirror(url);
                    },
                  ),
                  Divider(),
                  Text('Mirror order:'),
                  MirrorListView(urls: state.urls)
                ],
              ],
            ),
          ),
        ));
  }
}
