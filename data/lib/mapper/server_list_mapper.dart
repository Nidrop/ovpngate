import 'dart:convert';

import 'package:core/logger/logger.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:csv/csv.dart';
import 'package:data/entities/server_info_dto.dart';
import 'package:domain/models/server_info.dart';

sealed class ServerListMapper {
  static List<ServerInfoDto> csvToListServerInfoDto(String csv) {
    int rowLength = 15;

    List<ServerInfoDto> list = [];
    final csvList = const CsvToListConverter().convert(csv);
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
        AppLogger().info('row $i is not parsed');
        continue;
      }
    }
    return list;
  }

  static List<ServerInfo> listServerInfoDtoToModel({
    required List<ServerInfoDto> listDto,
  }) {
    return List.generate(
      listDto.length,
      (index) => ServerInfo(
        speed: (listDto[index].speed / 1000 / 1000).round(),
        countryShort: listDto[index].countryShort,
        sessions: listDto[index].numVpnSessions,
        uptime: (listDto[index].uptime / 1000 / 60 / 60 / 24).round(),
        name: listDto[index].hostName,
        ovpnConfig:
            utf8.decode(base64Decode(listDto[index].openVPNConfigDataBase64)),
        ovpnConfigPath: listDto[index].openVPNConfigPath,
      ),
    );
  }

  static List<ServerInfoDto> htmlTolistServerInfoDto(String html) {
    List<ServerInfoDto> list = [];

    final document = parse(html);
    final tables = document.getElementsByTagName('table');
    assert(tables.isNotEmpty);

    late final List<Element> trList;

    for (final table in tables) {
      final trs = table.getElementsByTagName('tr');
      if (trs.isEmpty) continue;
      final tds = trs.first.children;
      if (tds.length == 10) {
        trList = trs;
        break;
      }
    }

    for (final tr in trList) {
      late String countryLong;
      late String countryShort;
      late int numVpnSessions;
      late int uptime;
      late int speed;
      final params = Map<String, String>();

      if (tr.getElementsByClassName('vg_table_header').isNotEmpty) continue;

      final tdList = tr.children;
      assert(tdList.length == 10);

      //7
      final a = tdList[6].getElementsByTagName('a');
      if (a.length != 1) continue;
      final href = a.first.attributes['href'];
      assert(href != null);
      final paramStr = href!.split('?').last;
      final paramSplit = paramStr.split('&');
      bool skipWithoutTcp = false;
      for (final pair in paramSplit) {
        final pairSplit = pair.split('=');
        assert(pairSplit.length == 2);
        params[pairSplit.first] = pairSplit.last;
        if (pairSplit.first == 'tcp' && pairSplit.last == '0') {
          skipWithoutTcp = true;
          break;
        }
      }
      if (skipWithoutTcp) continue;
      final String openVPNConfigPath =
          "/common/openvpn_download.aspx?sid=${params['sid']!}&tcp=1&host=${params['ip']!}&port=${params['tcp']!}&hid=${params['hid']!}&/vpngate_${params['ip']!}_tcp_${params['tcp']!}.ovpn";

      //1
      countryLong = tdList[0].text;
      final img = tdList[0].getElementsByTagName('img');
      assert(img.length == 1);
      final imgSrc = img.first.attributes['src'];
      assert(imgSrc != null);
      final imgStr = imgSrc!.split('/').last;
      countryShort = imgStr.split('.').first;

      //3
      var spans = tdList[2].getElementsByTagName('span');
      assert(spans.length == 2);
      final sessionStr = spans.first.text.split(' ').first;
      final sessions = int.tryParse(sessionStr);
      assert(sessions != null);
      numVpnSessions = sessions!;
      final days = int.tryParse(spans[1].text.split(' ').first);
      assert(days != null);
      uptime = days! * 1000 * 60 * 60 * 24;

      //4
      var span = tdList[3].getElementsByTagName('span').first;
      var speedStr = span.text.split(' ').first;
      speedStr = speedStr.replaceAll(RegExp(','), '');
      final splitStr = speedStr.split('.');
      assert(splitStr.length == 2);
      speed = (int.parse(splitStr.first) * 100 + int.parse(splitStr.last)) *
          10 *
          1000;

      //TODO fill all fields
      list.add(
        ServerInfoDto(
          hostName: params['fqdn']!.split('.opengw.net').first,
          ip: params['ip']!,
          score: -1,
          ping: -1,
          speed: speed,
          countryLong: countryLong,
          countryShort: countryShort,
          numVpnSessions: numVpnSessions,
          uptime: uptime,
          totalUsers: -1,
          totalTraffic: -1,
          logType: '',
          operator: '',
          message: '',
          openVPNConfigDataBase64: '',
          openVPNConfigPath: openVPNConfigPath,
        ),
      );
    }

    return list;
  }
}

// class OvpnRequestParams {
//   int sid;
//   int host;
//   int port;
//   int hid;
// }
