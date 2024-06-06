import 'package:core/constants/api_constants.dart';
import 'package:data/entities/server_info_dto.dart';
import 'package:data/mapper/server_list_mapper.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';
part 'api_provider.g.dart';

@RestApi()
abstract class ApiProvider {
  factory ApiProvider(Dio dio) = _ApiProvider;

  @GET(ApiConstants.serverList)
  Future<String> getServerListString();

  // Future<List<ServerInfoDto>> getServerList() async {
  //   return ServerListMapper.stringToListServerInfoDto(
  //     rawCSV: await getServerListString(),
  //   );
  // }

  // void setToken(String? token);
}
