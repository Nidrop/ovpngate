class ServerInfo {
  ServerInfo({
    required this.speed,
    required this.sessions,
    required this.uptime,
    required this.name,
    required this.ovpnConfig,
  });
  final String name;
  final String ovpnConfig;
  final int speed;
  final int sessions;
  final int uptime;
}
