import 'package:core/core.dart';
import 'package:core/localization/app_localization.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/models/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:settings/settings_screen.dart';
import 'package:data/di/data_di.dart';

void main() {
  testWidgets('Settings screen test', (tester) async {
    await tester.pumpWidget(ThemeInheritedWidget(
      themeMode: ThemeMode.system,
      updateTheme: () {},
      child: /*EasyLocalization(
        supportedLocales: AppLocalization.supportedLocales,
        path: AppLocalization.langsFolderPath,
        fallbackLocale: AppLocalization.fallbackLocale,
        child:*/
          ThemeInheritedWidget(
        themeMode: ThemeMode.system,
        updateTheme: () {},
        child: Builder(builder: (context) {
          return MaterialApp(
            // localizationsDelegates: context.localizationDelegates,
            // supportedLocales: context.supportedLocales,
            // locale: context.locale,
            home: SettingsScreen(
              settingsInit: Settings(
                urls: ApiConstants.staticMirrorList,
                index: 0,
              ),
            ),
          );
        }),
      ),
      // ),
    ));

    final fetchSwitch = find.byType(Switch);
    expect(fetchSwitch, findsOneWidget);
    expect(find.byType(ReorderableListView), findsNothing);
    await tester.tap(fetchSwitch);
    await tester.pump();
    expect(find.byType(ReorderableListView), findsOne);
  });
}
