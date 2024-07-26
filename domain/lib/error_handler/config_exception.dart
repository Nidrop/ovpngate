class ConfigException implements Exception {
  final String message;

  ConfigException(
    this.message,
  );

  @override
  String toString() => message;

  factory ConfigException.unknown() => ConfigException('Unknown Error!');
}
