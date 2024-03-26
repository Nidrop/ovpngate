import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
import 'package:ovpngate/core/domain/entity/server_info.dart';
import 'package:ovpngate/core/presentation/bloc/connected_server_state.dart';
import 'package:ovpngate/core/utils/app_paths.dart';

class ConnectedServerCubit extends Cubit<ConnectedServerState> {
  //TODO simplify constructor
  ConnectedServerCubit()
      : super(
          ConnectedServerState(
            vpnstage: VPNStage.unknown,
            configCipherFix: true,
            openvpn: OpenVPN(),
          ),
        ) {
    final OpenVPN openVPN = OpenVPN(
        onVpnStatusChanged: _onVpnStatusChanged,
        onVpnStageChanged: _onVpnStageChanged);
    openVPN.initialize(
      // groupIdentifier: 'vpngate.net',
      // providerBundleIdentifier: 'net.vpn.ovpngate',
      localizedDescription: 'oVPNGate',
    );
    openVPN.stage().then(
          (stage) => _lastConnected().then(
            (server) => emit(
              ConnectedServerState(
                server: (stage != VPNStage.disconnected) ? server : null,
                openvpn: openVPN,
                vpnstage: stage,
                configCipherFix: true,
              ),
            ),
          ),
        );
  }

  // OpenVPN _factoryCreateOpenvpn() {
  //   if (state.openvpn.onVpnStageChanged == null ||
  //       state.openvpn.onVpnStatusChanged == null) {
  //     final OpenVPN openVPN = OpenVPN(
  //         onVpnStatusChanged: _onVpnStatusChanged,
  //         onVpnStageChanged: _onVpnStageChanged);
  //     openVPN.initialize(
  //       // groupIdentifier: 'vpngate.net',
  //       // providerBundleIdentifier: 'net.vpn.ovpngate',
  //       localizedDescription: 'oVPNGate',
  //     );
  //     return openVPN;
  //   }
  //   return state.openvpn;
  // }

  void _onVpnStatusChanged(VpnStatus? vpnStatus) {}

  void _onVpnStageChanged(VPNStage stage, String rawStage) {
    debugPrint('DEBUG: $rawStage');
    emit(ConnectedServerState(
      server: state.server,
      openvpn: state.openvpn,
      vpnstage: stage,
      configCipherFix: state.configCipherFix,
    ));
  }

  //TODO find alternative way to get connected name
  Future<ServerInfo?> _lastConnected({String? name}) async {
    final path = '${await AppPaths.getCacheDirPath()}/lastConnectedName.txt';
    final f = File(path);
    if (name != null) {
      await f.writeAsString(name);
      return null;
    } else {
      if (await f.exists()) {
        String loadedName = await f.readAsString();
        return ServerInfo(
            speed: -1,
            countryShort: "none",
            sessions: -1,
            uptime: -1,
            name: loadedName,
            ovpnConfig: "none");
      } else {
        return null;
      }
    }
  }

  String _configPatches(String ovpnConfig) {
    if (state.configCipherFix) {
      //TODO: refactoring
      final result = ovpnConfig.replaceAll(RegExp(r'cipher '), 'data-ciphers ');
      debugPrint('PATCHED');
      return result;
    }
    return ovpnConfig;
  }

  void setConfigCipherFix(bool value) {
    emit(ConnectedServerState(
      server: state.server,
      openvpn: state.openvpn,
      vpnstage: state.vpnstage,
      configCipherFix: value,
    ));
  }

  void setServer(ServerInfo server) {
    emit(ConnectedServerState(
      server: server,
      openvpn: state.openvpn,
      vpnstage: state.vpnstage,
      configCipherFix: state.configCipherFix,
    ));
  }

  void connect() {
    // debugPrint('WITHOUT PATCH');
    // debugPrint(state.server!.ovpnConfig);
    // debugPrint('WITH PATHCH');
    // debugPrint(_configPatches(state.server!.ovpnConfig));
    if (/*state.vpnstage == VPNStage.disconnected &&*/ state.server != null) {
      state.openvpn.connect(
        _configPatches(state.server!.ovpnConfig),
        state.server!.name,
        // username: username,
        // password: password,
        // bypassPackages: [],
        certIsRequired: true,
      );
      _lastConnected(name: state.server!.name);
    }
  }

  void disconnect() {
    if (state.server != null) {
      state.openvpn.disconnect();
    }
  }
}
