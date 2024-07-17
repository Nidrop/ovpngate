import 'package:core/core.dart';
import 'package:domain/models/settings.dart';
import 'package:domain/repositories/i_settings_service.dart';
import 'package:navigation/navigation.dart';

class SettingsCubit extends Cubit<Settings> {
  SettingsCubit(super.initialState);

  void saveSettings() {
    var settingsService = appLocator.get<ISettingsService>();
    settingsService.settings = state;
    settingsService.saveSettings();
    final appRouter = appLocator.get<AppRouter>();
    appRouter.maybePop();
  }

  void changeTheme(int index) {
    final themeMode = EnThemeMode.values[index];
    emit(state.copyWith(themeMode: themeMode));
  }

  void changeFetch(bool val) {
    late final FetchMode fetchMode;
    if (val) {
      fetchMode = FetchMode.html;
    } else {
      fetchMode = FetchMode.csv;
    }
    emit(state.copyWith(fetchMode: fetchMode));
  }

  void changeMirrorsOrder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final list = state.urls;
    final String item = list.removeAt(oldIndex);
    list.insert(newIndex, item);
    emit(state.copyWith(urls: list));
  }
}
