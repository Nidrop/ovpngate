import 'package:data/entities/server_info_dto.dart';
import 'package:data/mapper/server_list_mapper.dart';
import 'package:dio/dio.dart';

class VpngateRemoteSource {
  final String baseURL = 'http://www.vpngate.net';
  final String serverListPath = '/api/iphone/';

  final Dio dio;

  VpngateRemoteSource(this.dio);

  Future<List<ServerInfoDto>> getServerList() async {
    final response = await dio.get<String>(baseURL + serverListPath,
        options: Options(
          contentType: Headers.textPlainContentType,
          responseType: ResponseType.plain,
        ));

    if (response.statusCode == 200) {
      final value = response.data!;

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

    if (response.statusCode == 200) {
      final value = response.data!;

      return value;
    } else {
      throw Exception(
          'Failed to load server list from ${baseURL + serverListPath}');
    }
  }
}
