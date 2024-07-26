import 'package:core/core.dart';
import 'package:core/localization/generated/locale_keys.g.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/models/settings.dart';
import 'package:domain/repositories/i_settings_service.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:settings/src/bloc/settings_cubit.dart';
import 'package:settings/src/settings_content.dart';
import 'package:settings/src/widgets/fetch_switch.dart';
import 'package:settings/src/widgets/mirror_list_view.dart';
import 'package:settings/src/widgets/mirror_text_field.dart';
import 'package:settings/src/widgets/theme_toggle.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, this.settingsInit});
  final Settings? settingsInit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SettingsCubit(
            settingsInit ?? appLocator.get<ISettingsService>().settings.copy()),
        child: const SettingsContent());
  }
}
