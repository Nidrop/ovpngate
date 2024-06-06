import 'package:data/mapper/server_list_mapper.dart';
import 'package:data/providers/api_provider.dart';
import 'package:domain/models/server_info.dart';
import 'package:domain/repositories/i_repository.dart';

class VpngateRepository implements IRepository {
  final ApiProvider remoteSource;
  // final VpngateLocalSource localSource;

  VpngateRepository({
    required this.remoteSource,
    // required this.localSource,
  });

  @override
  Future<List<ServerInfo>> getServerList(
      {bool forceRefresh = false, bool getCache = false}) async {
    assert((forceRefresh && getCache) != true);

    final dto = ServerListMapper.stringToListServerInfoDto(
      rawCSV: await remoteSource.getServerListString(),
    );

    // late List<ServerInfoDto> listDto;
    // final cacheIsRelevant = (await localSource.isFileRelevant()) || getCache;
    // if (!cacheIsRelevant || forceRefresh) {
    //   final String csv = await remoteSource.getServerListCSV();
    //   localSource.saveFile(contents: csv);
    //   listDto = ServerListMapper.stringToListServerInfoDto(rawCSV: csv);
    // } else {
    //   listDto = await localSource.getServerList();
    // }

    final List<ServerInfo> result =
        ServerListMapper.listServerInfoDtoToModel(listDto: dto);
    return result;
  }
}
