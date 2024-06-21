import 'dart:io';

import 'package:path_provider/path_provider.dart';

sealed class AppPaths {
  static Future<String> getCacheDirPath() async {
    if (Platform.isAndroid) {
      final dirs = await getExternalCacheDirectories();
      if (dirs != null) {
        return dirs.first.path;
      }
      return (await getTemporaryDirectory()).path;
    }
    return (await getApplicationCacheDirectory()).path;
  }

  static Future<String> getConfigDirPath() async {
    Directory? dir;
    if (Platform.isAndroid) {
      dir = await getExternalStorageDirectory();
      if (dir != null) {
        return dir.path;
      }
    }
    return (await getApplicationSupportDirectory()).path;
  }
}
