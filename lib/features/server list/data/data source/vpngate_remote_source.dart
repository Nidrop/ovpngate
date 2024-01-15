import 'package:csv/csv.dart';
import 'package:dio/dio.dart';
import 'package:ovpngate/features/server%20list/data/dto/server_info_dto.dart';

class VpngateRemoteSource {
  final String baseURL = 'http://www.vpngate.net';
  final String serverListPath = '/api/iphone/';
  final int rowLength = 15;

  final Dio dio;

  VpngateRemoteSource(this.dio);

  Future<List<ServerInfoDto>> getServerList() async {
    final response = await dio.get<String>(baseURL + serverListPath);

    List<ServerInfoDto> list = [];

    if (response.statusCode == 200) {
      final value = response.data!;
      final csvList = const CsvToListConverter().convert(value);
      for (int i = 2; i < csvList.length; i++) {
        final row = csvList[i];
        if (row.length != rowLength) {
          continue;
        }
        list.add(
          ServerInfoDto(
            hostName: row[0] as String,
            ip: row[1] as String,
            score: row[2] as int,
            ping: row[3] as int,
            speed: row[4] as int,
            countryLong: row[5] as String,
            countryShort: row[6] as String,
            numVpnSessions: row[7] as int,
            uptime: row[8] as int,
            totalUsers: row[9] as int,
            totalTraffic: row[10] as int,
            logType: row[11] as String,
            operator: row[12] as String,
            message: row[13] as String,
            openVPNConfigDataBase64: row[14] as String,
          ),
        );
      }
    } else {
      throw Exception(
          'Failed to load server list from ${baseURL + serverListPath}');
    }

    return list;
  }
}
