part of core_ui;

abstract class AppColors {
  factory AppColors.of(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    return brightness == Brightness.light
        ? const LightColors()
        : const DarkColors();
  }

  Color get primaryBg;

  Color get white;
}

class DarkColors extends LightColors {
  const DarkColors();

  @override
  Color get primaryBg => Color.fromARGB(255, 210, 225, 235);

  @override
  Color get white => const Color.fromRGBO(100, 100, 100, 1);
}

class LightColors implements AppColors {
  const LightColors();

  @override
  // RGBO(236, 239, 241, 1)
  Color get primaryBg => const Color(0xFFeceff1);

  @override
  Color get white => const Color.fromRGBO(255, 255, 255, 1);
}
