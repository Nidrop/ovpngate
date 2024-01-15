import 'dart:convert';

import 'package:ovpngate/core/domain/entity/server_info.dart';
import 'package:ovpngate/features/server%20list/data/data%20source/vpngate_remote_source.dart';

class VpngateRepository {
  final VpngateRemoteSource remoteSource;

  VpngateRepository({
    required this.remoteSource,
  });

  Future<List<ServerInfo>> getServerList() async {
    final list = await remoteSource.getServerList();
    final List<ServerInfo> result = List.generate(
      list.length,
      (index) => ServerInfo(
        speed: list[index].speed,
        sessions: list[index].numVpnSessions,
        uptime: list[index].uptime,
        name: list[index].hostName,
        ovpnConfig:
            utf8.decode(base64Decode(list[index].openVPNConfigDataBase64)),
      ),
    );
    return result;
  }
}
