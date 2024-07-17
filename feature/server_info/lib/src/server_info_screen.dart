import 'package:core/localization/generated/locale_keys.g.dart';
import 'package:domain/models/server_info.dart';
import 'package:domain/repositories/i_vpn_service.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:navigation/navigation.dart';
import 'package:server_info/src/bloc/server_info_cubit.dart';
import 'package:server_info/src/bloc/server_info_state.dart';
import 'package:server_info/src/server_info_content.dart';

@RoutePage()
class ServerInfoScreen extends StatelessWidget {
  const ServerInfoScreen({super.key, required this.selectedServer});

  final ServerInfo selectedServer;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ServerInfoCubit(
          SelectedServerState(selectedServer: selectedServer),
          vpnService: appLocator.get<IVpnService>()),
      child: const ServerInfoContent(),
    );
  }
}
