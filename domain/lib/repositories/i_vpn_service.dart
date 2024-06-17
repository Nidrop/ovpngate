import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/models/server_info.dart';

abstract class IVpnService {
  ServerInfo? server;
  //TODO abstract
  VPNStage vpnstage = VPNStage.unknown;

  StreamController stageSC = StreamController<VPNStage>.broadcast();
  Stream get stageStream => stageSC.stream;

  void connect(ServerInfo server) {}

  void disconnect() {}
}
