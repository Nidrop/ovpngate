import 'dart:io';

import 'package:data/mapper/server_list_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

Future<String> readHtml() async {
  File f = File('test/resources/vpngate-servers.html');
  return await f.readAsString();
}

void main() {
  test('html successfully parsed', () async {
    final String htmlStr = await readHtml();
    final listDto = ServerListMapper.htmlTolistServerInfoDto(htmlStr);
    expect(listDto.first.countryLong, 'Japan');
    expect(listDto.first.countryShort, 'JP');
    expect(listDto.first.numVpnSessions, 73);
    expect(listDto.first.uptime, 24 * 1000 * 60 * 60 * 24);
    expect(listDto.first.speed, 112414 * 10 * 1000);
    expect(listDto.first.hostName, 'public-vpn-61');
    expect(listDto.first.ip, '219.100.37.51');

    // expect(listDto.length, 94); // all ovpn configs
    expect(listDto.length, 86); // all tcp ovpn cpnfigs
  });
}
