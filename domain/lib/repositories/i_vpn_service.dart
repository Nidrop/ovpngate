import 'dart:async';

import 'package:domain/models/server_info.dart';

enum EnVPNStage {
  prepare,
  authenticating,
  connecting,
  authentication,
  connected,
  disconnected,
  disconnecting,
  denied,
  error,
// ignore: constant_identifier_names
  wait_connection,
// ignore: constant_identifier_names
  vpn_generate_config,
// ignore: constant_identifier_names
  get_config,
// ignore: constant_identifier_names
  tcp_connect,
// ignore: constant_identifier_names
  udp_connect,
// ignore: constant_identifier_names
  assign_ip,
  resolve,
  exiting,
  unknown
}

abstract class IVpnService {
  ServerInfo? server;
  EnVPNStage vpnstage = EnVPNStage.unknown;

  StreamController stageSC = StreamController<EnVPNStage>.broadcast();
  Stream get stageStream => stageSC.stream;

  void connect(ServerInfo server) {}

  void disconnect() {}
}
