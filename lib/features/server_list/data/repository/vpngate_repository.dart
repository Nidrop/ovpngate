import 'package:ovpngate/core/domain/entity/server_info.dart';
import 'package:ovpngate/core/domain/repository/vpn_repository.dart';
import 'package:ovpngate/features/server_list/data/data_source/vpngate_remote_source.dart';
import 'package:ovpngate/features/server_list/data/mapper/server_list_mapper.dart';
import 'package:ovpngate/features/shared_features/one_day_file_cache_manager.dart';

class VpngateRepository implements VpnRepository {
  final VpngateRemoteSource remoteSource;
  final OneDayFileCacheManager localSource;

  final String _cacheKey;

  VpngateRepository({
    required this.remoteSource,
    required this.localSource,
    required cacheKey,
  }) : _cacheKey = cacheKey;

  @override
  Future<List<ServerInfo>> getServerList({
    bool forceRefresh = false,
    bool getCache = false,
  }) async {
    assert((forceRefresh && getCache) != true);

    final String? cachedCSV = await localSource.read(
      key: _cacheKey,
      getExpired: getCache,
    );
    if (cachedCSV != null && !forceRefresh) {
      return ServerListMapper.fromCSV(csv: cachedCSV);
    }

    final String csv = await remoteSource.getServerList();
    localSource.save(key: _cacheKey, content: csv);
    return ServerListMapper.fromCSV(csv: csv);
  }
}
