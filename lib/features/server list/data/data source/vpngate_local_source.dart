import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:ovpngate/features/server%20list/data/dto/server_list_mapper.dart';
import 'package:ovpngate/core/utils/app_paths.dart';
import 'package:ovpngate/features/server%20list/data/dto/server_info_dto.dart';

class VpngateLocalSource {
  final String relativeServerListPath = '/vpngate.csv';
  final int rowLength = 15;

  Future<List<ServerInfoDto>> getServerList({String? relativePath}) async {
    return ServerListMapper.stringToListServerInfoDto(
      rawCSV: await readFile(relativePath: relativePath),
    );
  }

  //TODO check date
  Future<bool> isFileRelevant({String? relativePath}) async {
    relativePath ??= relativeServerListPath;

    final path = (await AppPaths.getCacheDirPath()) + relativePath;
    final f = File(path);
    if (await f.exists()) {
      return true;
    } else {
      return false;
    }
  }

  Future<File> saveFile({
    String? relativePath,
    required String contents,
  }) async {
    relativePath ??= relativeServerListPath;

    final path = (await AppPaths.getCacheDirPath()) + relativePath;
    debugPrint(path);
    final f = File(path);
    return await f.writeAsString(contents);
  }

  Future<String> readFile({
    String? relativePath,
  }) async {
    relativePath ??= relativeServerListPath;

    final path = (await AppPaths.getCacheDirPath()) + relativePath;
    final f = File(path);
    if (await f.exists()) {
      return await f.readAsString();
    } else {
      throw Exception('Failed to read file from $path. File does not exist');
    }
  }
}
