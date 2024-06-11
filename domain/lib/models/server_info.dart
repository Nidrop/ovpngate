class ServerInfo {
  ServerInfo({
    required this.speed,
    required this.countryShort,
    required this.sessions,
    required this.uptime,
    required this.name,
    required this.ovpnConfig,
  });

  final String name;
  final String ovpnConfig;
  final int speed;
  final String countryShort;
  final int sessions;
  final int uptime;

  // ServerInfo copyWith({
  //   String? name,
  //   String? ovpnConfig,
  //   int? speed,
  //   String? countryShort,
  //   int? sessions,
  //   int? uptime,
  // }) {
  //   return ServerInfo(
  //     speed: speed ?? this.speed,
  //     countryShort: countryShort ?? this.countryShort,
  //     sessions: sessions ?? this.sessions,
  //     uptime: uptime ?? this.uptime,
  //     name: name ?? this.name,
  //     ovpnConfig: ovpnConfig ?? this.name,
  //   );
  // }
}
