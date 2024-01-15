import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovpngate/core/domain/entity/server_info.dart';
import 'package:ovpngate/features/server%20list/data/repository/vpngate_repository.dart';

class ServerListCubit extends Cubit<Future<List<ServerInfo>>> {
  final VpngateRepository repository;

  ServerListCubit(this.repository) : super(repository.getServerList());

  void getServerList() {
    emit(repository.getServerList());
  }
}
