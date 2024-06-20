import 'dart:convert';
import 'dart:io';

import 'package:core/config/app_config.dart';
import 'package:core/core.dart';
import 'package:path/path.dart' as p;

abstract class LocalDataProvider {
  Future<void> write({required String key, required String value});

  Future<String?> read(String key);

  Future<void> delete(String key);

  Future<void> deleteAll();

  Future<bool> contains(String key);
}

class LocalCacheProviderImpl implements LocalDataProvider {
  AppConfig appConfig;
  Duration relevantDifference;
  late final String path = appConfig.cachePath;

  LocalCacheProviderImpl({
    required this.appConfig,
    this.relevantDifference = const Duration(hours: 4),
  });

  @override
  Future<bool> contains(String key) {
    // TODO: implement contains
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String key) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll() {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }

  @override
  bool deleteIfExpired(String key) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAllExpired() {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }

  @override
  Future<String?> read(String key) async {
    final f = File(p.join(path, key));
    if (!(await f.exists())) {
      return null;
    }

    final jsonStr = await f.readAsString();
    final json = jsonDecode(jsonStr) as Map<String, dynamic>;

    final String? dateString = json["date"];
    if (dateString == null) {
      return null;
    }
    final DateTime? date = DateTime.tryParse(dateString);

    if (date != null && _isExpired(date)) {
      // delete(key);
      return null;
    }

    final String? objectString = json["object"];
    if (objectString == null) {
      return null;
    }

    return objectString;
  }

  @override
  Future<void> write({required String key, required String value}) async {
    final obj = {
      "date": DateTime.now().toIso8601String(),
      "object": value,
    };
    final jsonStr = jsonEncode(obj);

    final f = File(p.join(path, key));
    await f.writeAsString(jsonStr);
  }

  bool _isExpired(DateTime d) {
    final dn = DateTime.now();
    if (relevantDifference > d.difference(dn)) {
      return false;
    }
    return true;
  }
}
