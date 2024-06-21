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

  // factory AppConfig.fromFlavor(Flavor flavor) {
  //   String baseUrl;
  //   String webSocketUrl;
  //   switch (flavor) {
  //     case Flavor.dev:
  //       baseUrl = '';
  //       webSocketUrl = '';
  //       break;
  //     case Flavor.canary:
  //       baseUrl = '';
  //       webSocketUrl = '';
  //       break;
  //   }

  //   return AppConfig(
  //     flavor: flavor,
  //     baseUrl: baseUrl,
  //     webSocketUrl: webSocketUrl,
  //   );
  // }
}
