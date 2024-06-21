import 'package:domain/models/server_info.dart';

sealed class ServerInfoMapper {
  static Map<String, dynamic> serverInfoToJson(ServerInfo server) {
    return {
      "name": server.name,
      "ovpnConfig": server.ovpnConfig,
      "speed": server.speed,
      "countryShort": server.countryShort,
      "sessions": server.sessions,
      "uptime": server.uptime,
    };
  }

  static ServerInfo jsonToServerInfo(Map<String, dynamic> json) {
    return ServerInfo(
      speed: json["speed"],
      countryShort: json["countryShort"],
      sessions: json["sessions"],
      uptime: json["uptime"],
      name: json["name"],
      ovpnConfig: json["ovpnConfig"],
    );
  }
}
