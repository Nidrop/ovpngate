import 'dart:convert';

import 'package:data/entities/server_info_dto.dart';
import 'package:data/mapper/server_list_mapper.dart';
import 'package:data/providers/api_provider.dart';
import 'package:data/providers/local_data_provider.dart';
import 'package:domain/models/server_info.dart';
import 'package:domain/repositories/i_repository.dart';

class VpngateRepository implements IRepository {
  final ApiProvider remoteProvider;
  final LocalDataProvider localProvider;

  VpngateRepository({
    required this.remoteProvider,
    required this.localProvider,
  });

  @override
  Future<List<ServerInfo>> getServerList(
      {required bool forceRefresh, required bool getCache}) async {
    assert((forceRefresh && getCache) != true);

    const cacheKey = 'vpngate-list.json';
    List<ServerInfoDto> dto;

    final dtoString = await localProvider.read(cacheKey);
    if ((dtoString == null || forceRefresh) &&
        (dtoString == null || !getCache)) {
      dto = ServerListMapper.stringToListServerInfoDto(
        rawCSV: await remoteProvider.getServerListString(),
      );
      localProvider.write(key: cacheKey, value: jsonEncode(dto));
    } else {
      final List<dynamic> jsonList = jsonDecode(dtoString);
      dto = [for (final e in jsonList) ServerInfoDto.fromJson(e)];
    }

    final List<ServerInfo> result =
        ServerListMapper.listServerInfoDtoToModel(listDto: dto);
    return result;
  }
}
