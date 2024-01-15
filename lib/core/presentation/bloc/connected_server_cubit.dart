import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovpngate/core/domain/entity/server_info.dart';
import 'package:ovpngate/core/presentation/bloc/connected_server_state.dart';

class ConnectedServerCubit extends Cubit<ConnectedServerState> {
  ConnectedServerCubit() : super(ConnectedServerState(isConnected: false));

  void connectTo(ServerInfo server) {
    emit(ConnectedServerState(
      isConnected: false,
      isLoading: true,
      server: server,
    ));
  }

  void disconnect() {
    emit(
      ConnectedServerState(
        isConnected: false,
        isLoading: false,
      ),
    );
  }
}
