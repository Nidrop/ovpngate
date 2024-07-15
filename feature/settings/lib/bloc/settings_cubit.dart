import 'package:core/core.dart';
import 'package:domain/repositories/i_settings_service.dart';
import 'package:navigation/navigation.dart';
import 'package:settings/bloc/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState());

  void saveSettings() {
    final settingsService = appLocator.get<ISettingsService>();
    settingsService.saveSettings(settingsService.settings);
    final appRouter = appLocator.get<AppRouter>();
    appRouter.maybePop();
  }
}
