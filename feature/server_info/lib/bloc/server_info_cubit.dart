import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/repositories/i_vpn_service.dart';
import 'package:server_info/bloc/server_info_state.dart';

class ServerInfoCubit extends Cubit<ServerInfoState> {
  final IVpnService vpnService;
  late final StreamSubscription _streamSubscription;

  ServerInfoCubit(super.initialState, {required this.vpnService}) {
    if (vpnService.server != null) {
      emit(ConnectedServerState(
        selectedServer: state.selectedServer,
        connectedServer: vpnService.server!,
        stage: vpnService.vpnstage,
      ));
    }

    _streamSubscription =
        vpnService.stageStream.listen((stage) => _stageChanged(stage));
  }

  void _stageChanged(VPNStage stage) {
    if (stage == VPNStage.disconnected) {
      emit(SelectedServerState(selectedServer: state.selectedServer));
    } else if (state is ConnectedServerState) {
      final s = state as ConnectedServerState;
      emit(ConnectedServerState(
        selectedServer: s.selectedServer,
        connectedServer: s.connectedServer,
        stage: stage,
      ));
    }
  }

  void connect() {
    disconnect();

    emit(ConnectedServerState(
      selectedServer: state.selectedServer,
      connectedServer: state.selectedServer,
      stage: vpnService.vpnstage,
    ));
    vpnService.connect(state.selectedServer);
  }

  void disconnect() {
    vpnService.disconnect();
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
