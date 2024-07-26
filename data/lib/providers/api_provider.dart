import 'package:core/constants/api_constants.dart';
import 'package:core/logger/logger.dart';
import 'package:data/entities/server_info_dto.dart';
import 'package:data/mapper/server_list_mapper.dart';
import 'package:dio/dio.dart';
import 'package:domain/models/settings.dart';
import 'package:domain/repositories/i_settings_service.dart';

class ApiProvider {
  final Dio dio;
  final ISettingsService settingsService;
  ApiProvider({
    required this.dio,
    required this.settingsService,
  });

  Future<List<ServerInfoDto>> getServerList() async {
    final settings = settingsService.settings;

    switch (settings.fetchMode) {
      case FetchMode.csv:
        {
          try {
            final url = ApiConstants.staticMirrorList.first +
                ApiConstants.apiServerList;
            final response = await dio.get(url);
            return ServerListMapper.csvToListServerInfoDto(response.data);
          } on DioException {
            rethrow;
          }
        }
      case FetchMode.html:
        {
          assert(settings.index <= settings.urls.length - 1);
          while (settings.index <= settings.urls.length - 1) {
            try {
              final url = settings.urls[settings.index];
              final response = await dio.get(url);

              return ServerListMapper.htmlTolistServerInfoDto(response.data);
            } on DioException catch (e) {
              if (e.type == DioExceptionType.connectionTimeout) {
                AppLogger().warning(
                    '${settings.urls[settings.index]} mirror is skipped , error: ${e.message}');
                ++settings.index;
                if (settings.index == settings.urls.length) {
                  settings.index = 0;
                  final message = 'All mirrors are not available: ${e.message}';
                  AppLogger().error(message);
                  throw Exception(message);
                }
                continue;
              } else {
                rethrow;
              }
            }
          }
        }
    }
    throw Exception('Never');
  }

  Future<String> getConfig(String path) async {
    final settings = settingsService.settings;
    final url = settings.urls[settings.index] + path;

    final response = await dio.get(url);
    final String data = response.data;
    return data;
  }

  // void setToken(String? token);
}
