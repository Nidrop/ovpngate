part of core_ui;

LightColors appColors = const LightColors();

final ThemeData lightTheme = ThemeData.light().copyWith(
  // appBarTheme: _getAppBarTheme(),
  scaffoldBackgroundColor: appColors.white,
  textTheme: _getTextTheme(),
  inputDecorationTheme: _getInputDecorationTheme(),
  primaryColor: appColors.primaryBg,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: appColors.primaryBg,
    primary: appColors.primaryBg,
  ),
);
final ThemeData darkTheme = ThemeData.dark().copyWith(
  // appBarTheme: _getAppBarTheme(),
  scaffoldBackgroundColor: appColors.white,
  textTheme: _getTextTheme(),
  inputDecorationTheme: _getInputDecorationTheme(),
  primaryColor: appColors.primaryBg,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: appColors.primaryBg,
    primary: appColors.primaryBg,
  ),
);
TextTheme _getTextTheme() {
  return TextTheme(
    titleMedium: AppFonts.normal13,
    bodyMedium: AppFonts.normal13,
  ).apply(
    bodyColor: appColors.primaryBg,
    displayColor: appColors.primaryBg,
  );
}

final lTheme = ThemeData.light();
final dTheme = ThemeData.dark();

InputDecorationTheme _getInputDecorationTheme() {
  return InputDecorationTheme(
    hintStyle: AppFonts.normal13.copyWith(color: appColors.primaryBg),
    border: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(AppDimens.BORDER_RADIUS_12),
      ),
      borderSide: BorderSide(
        color: appColors.primaryBg,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(AppDimens.BORDER_RADIUS_12),
      ),
      borderSide: BorderSide(
        color: appColors.primaryBg,
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(AppDimens.BORDER_RADIUS_6),
      ),
      borderSide: BorderSide(
        color: appColors.primaryBg,
        width: 2,
      ),
    ),
    labelStyle: AppFonts.normal13.copyWith(color: appColors.primaryBg),
  );
}
