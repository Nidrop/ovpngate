import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';

class CacheInterceptor extends DioCacheInterceptor {
  CacheInterceptor({required String cachePath})
      : super(
            options: CacheOptions(
          // A default store is required for interceptor.
          store: FileCacheStore(cachePath),

          // All subsequent fields are optional.

          // Default.
          policy: CachePolicy.forceCache,
          // Returns a cached response on error but for statuses 401 & 403.
          // Also allows to return a cached response on network errors (e.g. offline usage).
          // Defaults to [null].
          hitCacheOnErrorExcept: [401, 403],
          // Overrides any HTTP directive to delete entry past this duration.
          // Useful only when origin server has no cache config or custom behaviour is desired.
          // Defaults to [null].
          maxStale: const Duration(hours: 12),
          // Default. Allows 3 cache sets and ease cleanup.
          priority: CachePriority.high,
          // Default. Body and headers encryption with your own algorithm.
          cipher: null,
          // Default. Key builder to retrieve requests.
          // keyBuilder: CacheOptions.defaultCacheKeyBuilder,
          keyBuilder: (request) {
            return request.uri.toString();
          },
          // Default. Allows to cache POST requests.
          // Overriding [keyBuilder] is strongly recommended when [true].
          allowPostMethod: false,
        ));
}
