import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovpngate/core/di/di.dart';
import 'package:ovpngate/core/domain/entity/vpn_stage.dart';
import 'package:ovpngate/features/home/controller/home_controller.dart';

class HomePage extends ConsumerWidget with HomeState, HomeHandler {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(langProvider);
    final server = serverInfo(ref);
    final vpnstage = vpnStage(ref);

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.homeTitle),
        // actions: [
        //   IconButton(
        //     onPressed: changeTheme,
        //     icon: Icon(switch (themeMode) {
        //       ThemeMode.system => Icons.light_mode,
        //       ThemeMode.light => Icons.dark_mode,
        //       ThemeMode.dark => Icons.phone_android,
        //     }),
        //   ),
        // ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('${lang.vpnServer}:', style: TextStyle(fontSize: 20)),
                SizedBox(height: 20),
                if (server != null)
                  Text(
                    server.hostName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                else
                  Text(
                    lang.notSelected,
                    style: TextStyle(
                      // fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                SizedBox(height: 20),
                if (server != null)
                  Text(
                    vpnstage.name,
                    style: TextStyle(
                      // fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Center(
              child: (server != null)
                  ? (vpnstage == VpnStage.disconnected)
                        ? FilledButton(
                            onPressed: () =>
                                connectUsecase(ref, server: server),
                            child: Text(lang.connect),
                          )
                        : FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.error,
                            ),
                            onPressed: () => disconnectUsecase(ref),
                            child: Text(lang.disconnect),
                          )
                  : SizedBox(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => selectServerUsecase(ref),
        child: const Icon(Icons.list),
      ),
    );
  }
}
