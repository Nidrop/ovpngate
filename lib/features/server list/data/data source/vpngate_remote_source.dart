import 'dart:io';

import 'package:csv/csv.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:ovpngate/features/server%20list/data/dto/server_list_mapper.dart';
import 'package:ovpngate/features/server%20list/data/dto/server_info_dto.dart';
import 'package:path_provider/path_provider.dart';

class VpngateRemoteSource {
  final String baseURL = 'http://www.vpngate.net';
  final String serverListPath = '/api/iphone/';
  final int rowLength = 15;

  final Dio dio;

  VpngateRemoteSource(this.dio);

  Future<List<ServerInfoDto>> getServerList() async {
    final response = await dio.get<String>(baseURL + serverListPath,
        options: Options(
          contentType: Headers.textPlainContentType,
          responseType: ResponseType.plain,
        ));
    // final response = await http.get(Uri.parse(baseURL + serverListPath));

    if (response.statusCode == 200) {
      final value = response.data!;
      // final value = response.body;

      return ServerListMapper.stringToListServerInfoDto(
        rawCSV: value,
      );
    } else {
      throw Exception(
          'Failed to load server list from ${baseURL + serverListPath}');
    }
  }

  Future<String> getServerListCSV() async {
    final response = await dio.get<String>(baseURL + serverListPath,
        options: Options(
          contentType: Headers.textPlainContentType,
          responseType: ResponseType.plain,
        ));
    // final response = await http.get(Uri.parse(baseURL + serverListPath));

    if (response.statusCode == 200) {
      final value = response.data!;
      // final value = response.body;

      return value;
    } else {
      throw Exception(
          'Failed to load server list from ${baseURL + serverListPath}');
    }
  }
}
