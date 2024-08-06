import 'package:core/core.dart';
import 'package:core/localization/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:server_info/src/bloc/server_info_cubit.dart';
import 'package:server_info/src/bloc/server_info_state.dart';

class ServerInfoContent extends StatelessWidget {
  const ServerInfoContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ServerInfoCubit, ServerInfoState>(
      listener: (context, state) {
        if (state is DisabledServerState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(LocaleKeys
                  .common_config_is_outdated_please_re_download_the_server_list
                  .tr())));
        } else if (state is ErrorServerState) {
          final String? error = state.error;
          if (error != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(error)));
          }
          context.read<ServerInfoCubit>().fixErrorState();
        }
      },
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
                      state.selectedServer.name,
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
              child: Center(
                child: BlocBuilder<ServerInfoCubit, ServerInfoState>(
                    builder: (context, state) {
                  if (state is ConnectedServerState &&
                      state.connectedServer.name == state.selectedServer.name) {
                    return FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                      onPressed: () {
                        context.read<ServerInfoCubit>().disconnect();
                      },
                      child: Text(context.tr(LocaleKeys.common_disconnect)),
                    );
                  } else if (state is DownloadingServerInfoState) {
                    return const FilledButton(
                      onPressed: null,
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is DisabledServerState) {
                    return FilledButton(
                      onPressed: null,
                      child: Text(context.tr(LocaleKeys.common_connect)),
                    );
                  } else {
                    return FilledButton(
                      onPressed: () {
                        context.read<ServerInfoCubit>().connect();
                      },
                      child: Text(context.tr(LocaleKeys.common_connect)),
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
