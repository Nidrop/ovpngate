enum Flavor {
  dev,
  canary,
}

class AppConfig {
  final Flavor flavor;
  final String baseUrl;
  final String cachePath;
  final String configPath;

  AppConfig({
    required this.flavor,
    required this.baseUrl,
    required this.cachePath,
    required this.configPath,
  });
}
