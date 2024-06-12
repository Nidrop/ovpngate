import 'package:core/core.dart';
import 'package:core_ui/src/widgets/core_bloc_di/connected_server_state.dart';
import 'package:domain/models/server_info.dart';

class ConnectedServerCubit extends Cubit<ConnectedServerState> {
  ConnectedServerCubit()
      : super(
          ConnectedServerState(
            vpnstage: VPNStage.unknown,
            configCipherFix: true,
            openvpn: OpenVPN(),
            server: null,
          ),
        ) {
    final vpn = OpenVPN(
      onVpnStageChanged: _onVpnStageChanged,
      onVpnStatusChanged: _onVpnStatusChanged,
    );
    vpn.initialize(
      localizedDescription: 'oVPNGate',
    );

    vpn.stage().then(
          (stage) => emit(
            ConnectedServerState(
              openvpn: vpn,
              // server: null,
              server: (stage != VPNStage.disconnected)
                  ? ServerInfo(
                      speed: -1,
                      countryShort: "",
                      sessions: -1,
                      uptime: -1,
                      name: "",
                      ovpnConfig: "")
                  : null,
              vpnstage: stage,
              configCipherFix: true,
            ),
          ),
        );
  }

  void _onVpnStatusChanged(VpnStatus? vpnStatus) {}

  void _onVpnStageChanged(VPNStage stage, String rawStage) {
    // debugPrint('DEBUG: $rawStage');
    emit(state.copyWith(
      vpnstage: stage,
      server: stage == VPNStage.disconnected ? () => null : null,
    ));
  }

  // TODO find alternative way to get connected name
  // Future<ServerInfo?> _lastConnected({String? name}) async {
  //   final path = '${await AppPaths.getCacheDirPath()}/lastConnectedName.txt';
  //   final f = File(path);
  //   if (name != null) {
  //     await f.writeAsString(name);
  //     return null;
  //   } else {
  //     if (await f.exists()) {
  //       String loadedName = await f.readAsString();
  //       return ServerInfo(
  //           speed: -1,
  //           countryShort: "none",
  //           sessions: -1,
  //           uptime: -1,
  //           name: loadedName,
  //           ovpnConfig: "none");
  //     } else {
  //       return null;
  //     }
  //   }
  // }

  String _configPatches(String ovpnConfig) {
    if (state.configCipherFix) {
      final result = ovpnConfig.replaceAll(RegExp(r'cipher '), 'data-ciphers ');
      return result;
    }
    return ovpnConfig;
  }

  void setConfigCipherFix(bool value) {
    emit(state.copyWith(
      configCipherFix: value,
    ));
  }

  void connect(ServerInfo server) {
    disconnect();

    state.openvpn.connect(
      _configPatches(server.ovpnConfig),
      server.name,
      // username: username,
      // password: password,
      // bypassPackages: [],
      certIsRequired: true,
    );

    emit(state.copyWith(
      server: () => server,
    ));
  }

  void disconnect() {
    if (state.server != null) {
      state.openvpn.disconnect();

      // emit(state.copyWith(
      //   server: () => null,
      // ));
    }
  }
}
