import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovpngate/core/domain/entity/vpn_stage.dart';
import 'package:ovpngate/core/lang/lang_en.dart';
import 'package:ovpngate/features/shared_features/openvpn_service.dart';
import 'package:ovpngate/features/server_list/data/data_source/vpngate_remote_source.dart';
import 'package:ovpngate/features/server_list/data/repository/vpngate_repository.dart';
import 'package:ovpngate/features/shared_features/one_day_file_cache_manager.dart';

// core

final langProvider = Provider((ref) => LangEN());
final oneDayFileCacheManagerProvider = FutureProvider(
  (ref) => OneDayFileCacheManager.create(appname: 'ovpngate', dirname: 'cache'),
);

// server list

final dioProvider = Provider((ref) => Dio());

final vpngateRepositoryProvider = FutureProvider((Ref ref) async {
  final dio = ref.watch(dioProvider);
  final cacheManager = await ref.watch(oneDayFileCacheManagerProvider.future);

  return VpngateRepository(
    remoteSource: VpngateRemoteSource(
      dio: dio,
      baseURL: 'https://www.vpngate.net',
      serverListPath: '/api/iphone/',
    ),
    localSource: cacheManager,
    cacheKey: 'vpngate.csv',
  );
});

// home

final openvpnServiceProvider = FutureProvider((ref) async {
  final cacheManager = await ref.watch(oneDayFileCacheManagerProvider.future);

  final openvpnService = OpenvpnService(
    cacheManager: cacheManager,
    //TODO get from settings
    configCipherFix: true,
    serverNameCacheKey: 'servername.txt',
  );

  openvpnService.ensureInitialized();

  return openvpnService;
});

final vpnStageProvider = StreamProvider<VpnStage>((ref) async* {
  final openvpnService = await ref.watch(openvpnServiceProvider.future);
  await for (final value in openvpnService.stageStream) {
    yield value;
  }
});
