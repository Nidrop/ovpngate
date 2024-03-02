import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:ovpngate/core/domain/entity/server_info.dart';
import 'package:ovpngate/features/server%20list/data/dto/server_info_dto.dart';

sealed class ServerListMapper {
  static List<ServerInfoDto> stringToListServerInfoDto({
    required String rawCSV,
  }) {
    int rowLength = 15;

    List<ServerInfoDto> list = [];
    final csvList = const CsvToListConverter().convert(rawCSV);
    for (int i = 0; i < csvList.length; i++) {
      final row = csvList[i];
      if (row.length != rowLength) {
        continue;
      }
      try {
        list.add(
          ServerInfoDto(
            hostName: row[0] as String,
            ip: row[1] as String,
            score: row[2] as int,
            ping: int.tryParse(row[3].toString()) ?? -1,
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
      } catch (e) {
        debugPrint('row $i is not parsed');
        continue;
      }
    }
    return list;
  }

  static List<ServerInfo> listServerInfoDtoToEntities({
    required List<ServerInfoDto> listDto,
  }) {
    return List.generate(
      listDto.length,
      (index) => ServerInfo(
        speed: listDto[index].speed,
        countryShort: listDto[index].countryShort,
        sessions: listDto[index].numVpnSessions,
        uptime: listDto[index].uptime,
        name: listDto[index].hostName,
        ovpnConfig:
            utf8.decode(base64Decode(listDto[index].openVPNConfigDataBase64)),
      ),
    );
  }
}
