import 'package:dio/dio.dart';

class VpngateRemoteSource {
  final String baseURL;
  final String serverListPath;

  final Dio dio;

  VpngateRemoteSource({
    required this.dio,
    required this.baseURL,
    required this.serverListPath,
  });

  Future<String> getServerList() async {
    final response = await dio.get<String>(
      baseURL + serverListPath,
      options: Options(
        contentType: Headers.textPlainContentType,
        responseType: ResponseType.plain,
      ),
    );

    return response.data as String;
  }
}
