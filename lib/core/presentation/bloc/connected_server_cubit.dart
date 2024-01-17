import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
import 'package:ovpngate/core/domain/entity/server_info.dart';
import 'package:ovpngate/core/presentation/bloc/connected_server_state.dart';

class ConnectedServerCubit extends Cubit<ConnectedServerState> {
  ConnectedServerCubit()
      : super(
          ConnectedServerState(
            vpnstage: VPNStage.disconnected,
            openvpn: OpenVPN(),
          ),
        );

  OpenVPN _factoryCreateOpenvpn() {
    if (state.openvpn.onVpnStageChanged == null ||
        state.openvpn.onVpnStatusChanged == null) {
      OpenVPN openVPN = OpenVPN(
          onVpnStatusChanged: _onVpnStatusChanged,
          onVpnStageChanged: _onVpnStageChanged);
      openVPN.initialize(
        // groupIdentifier: 'vpngate.net',
        // providerBundleIdentifier: 'net.vpn.ovpngate',
        localizedDescription: 'oVPNGate',
      );
      return openVPN;
    }
    return state.openvpn;
  }

  void _onVpnStatusChanged(VpnStatus? vpnStatus) {}

  void _onVpnStageChanged(VPNStage stage, String rawStage) {
    emit(ConnectedServerState(
      server: state.server,
      openvpn: _factoryCreateOpenvpn(),
      vpnstage: stage,
      configCipherFix: state.configCipherFix,
    ));
  }

  String _configPatches(String ovpnConfig) {
    if (state.configCipherFix) {
      debugPrint('PATCHED');
      //TODO: refactoring
      return ovpnConfig.replaceAll(RegExp(r'cipher '), 'data-cipher');
    }
    debugPrint('NOT PATCHED');
    return ovpnConfig;
  }

  void setConfigCipherFix(bool value) {
    emit(ConnectedServerState(
      server: state.server,
      openvpn: _factoryCreateOpenvpn(),
      vpnstage: state.vpnstage,
      configCipherFix: value,
    ));
  }

  void setServer(ServerInfo server) {
    emit(ConnectedServerState(
      server: server,
      openvpn: _factoryCreateOpenvpn(),
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
    }
  }

  void disconnect() {
    if (state.server != null) {
      state.openvpn.disconnect();
    }
  }
}
