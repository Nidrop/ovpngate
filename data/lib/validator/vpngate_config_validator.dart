class VpngateConfigValidator {
  static bool validate(String config) {
    final r = RegExp(r' <html>.|\n*?<\/html>');
    if (r.hasMatch(config)) {
      return false;
    }
    return true;
  }
}
