import 'package:ovpngate/core/domain/entity/server_info.dart';
import 'package:ovpngate/features/server%20list/data/data%20source/vpngate_local_source.dart';
import 'package:ovpngate/features/server%20list/data/data%20source/vpngate_remote_source.dart';
import 'package:ovpngate/features/server%20list/data/dto/server_info_dto.dart';
import 'package:ovpngate/features/server%20list/data/dto/server_list_mapper.dart';

class VpngateRepository {
  final VpngateRemoteSource remoteSource;
  final VpngateLocalSource localSource;

  VpngateRepository({
    required this.remoteSource,
    required this.localSource,
  });

  Future<List<ServerInfo>> getServerList(
      {bool forceRefresh = false, bool getCache = false}) async {
    //TODO refactor
    assert((forceRefresh && getCache) != true);

    late List<ServerInfoDto> listDto;
    final cacheIsRelevant = (await localSource.isFileRelevant()) || getCache;
    if (!cacheIsRelevant || forceRefresh) {
      final String csv = await remoteSource.getServerListCSV();
      localSource.saveFile(contents: csv);
      listDto = ServerListMapper.stringToListServerInfoDto(rawCSV: csv);
    } else {
      listDto = await localSource.getServerList();
    }

    final List<ServerInfo> result =
        ServerListMapper.listServerInfoDtoToEntities(listDto: listDto);
    return result;
  }
}
