import 'package:core/localization/generated/locale_keys.g.dart';
import 'package:domain/models/server_info.dart';
import 'package:domain/repositories/i_vpn_service.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:navigation/navigation.dart';
import 'package:server_info/bloc/server_info_cubit.dart';
import 'package:server_info/bloc/server_info_state.dart';

@RoutePage()
class ServerInfoScreen extends StatelessWidget {
  const ServerInfoScreen({super.key, required this.selectedServer});

  final ServerInfo selectedServer;

  void connect(BuildContext context) {
    context.read<ServerInfoCubit>().connect();
  }

  void disconnect(BuildContext context) {
    context.read<ServerInfoCubit>().disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ServerInfoCubit(
          SelectedServerState(selectedServer: selectedServer),
          vpnService: appLocator.get<IVpnService>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.tr(LocaleKeys.common_oVPNGate)),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: BlocBuilder<ServerInfoCubit, ServerInfoState>(
                  builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      context.tr(LocaleKeys.common_vpnServer),
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      selectedServer.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (state is ConnectedServerState &&
                        state.connectedServer.name == state.selectedServer.name)
                      Text(
                        state.stage.name,
                        style: TextStyle(
                            // fontSize: 20,
                            // fontWeight: FontWeight.bold,
                            ),
                      )
                  ],
                );
              }),
            ),
            Expanded(
              flex: 5,
              child: BlocBuilder<ServerInfoCubit, ServerInfoState>(
                  builder: (context, state) {
                return Center(
                  child: (state is ConnectedServerState &&
                          state.connectedServer.name ==
                              state.selectedServer.name)
                      ? FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                          ),
                          onPressed: () => disconnect(context),
                          child: Text(context.tr(LocaleKeys.common_disconnect)),
                        )
                      : FilledButton(
                          onPressed: () => connect(context),
                          child: Text(context.tr(LocaleKeys.common_connect)),
                        ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
