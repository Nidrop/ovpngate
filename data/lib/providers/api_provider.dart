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
    try {
      String url = settingsService.settings.currentUrl;
      if (settingsService.settings.fetchMode == FetchMode.csv) {
        url += ApiConstants.serverList;
      }
      final response = await dio.get(url);

      final String data = response.data;
      switch (settingsService.settings.fetchMode) {
        case FetchMode.csv:
          return ServerListMapper.csvToListServerInfoDto(data);
        case FetchMode.html:
          return ServerListMapper.htmlTolistServerInfoDto(data);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        // Handle connection timeout error
        AppLogger().warning('Connection timeout error: ${e.message}');
        rethrow;
      } else {
        rethrow;
      }
    }
  }

  Future<String> getConfig(String path) async {
    try {
      final url = settingsService.settings.currentUrl + path;

      final response = await dio.get(url);
      final String data = response.data;
      return data;
    } on DioException catch (e) {
      rethrow;
    }
  }

  // void setToken(String? token);
}
