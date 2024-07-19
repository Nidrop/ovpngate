import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/repositories/i_repository.dart';
import 'package:domain/repositories/i_vpn_service.dart';
import 'package:server_info/bloc/server_info_state.dart';

class ServerInfoCubit extends Cubit<ServerInfoState> {
  final IRepository vpnRepository;
  final IVpnService vpnService;
  late final StreamSubscription _streamSubscription;

  ServerInfoCubit(
    super.initialState, {
    required this.vpnRepository,
    required this.vpnService,
  }) {
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

  void _stageChanged(EnVPNStage stage) {
    if (stage == EnVPNStage.disconnected) {
      emit(SelectedServerState(selectedServer: state.selectedServer));
    } else {
      emit(ConnectedServerState(
        selectedServer: state.selectedServer,
        connectedServer: vpnService.server!,
        stage: stage,
      ));
    }
  }

  void connect() async {
    disconnect();

    if (state.selectedServer.ovpnConfigPath != null) {
      emit(DownloadingState(
        selectedServer: state.selectedServer,
      ));
      final config = await vpnRepository.getConfig(
          path: state.selectedServer.ovpnConfigPath!);
      emit(SelectedServerState(
        selectedServer: state.selectedServer.copyWith(ovpnConfig: config),
      ));
    } else {
      emit(SelectedServerState(
        selectedServer: state.selectedServer,
      ));
    }
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
