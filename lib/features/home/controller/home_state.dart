part of 'home_controller.dart';

mixin HomeState {
  ServerInfo? serverInfo(WidgetRef ref) => ref.watch(_serverInfoNotifier);
  VpnStage vpnStage(WidgetRef ref) => ref
      .watch(vpnStageProvider)
      .maybeWhen(
        data: (VpnStage stage) => stage,
        orElse: () => VpnService.defaultVpnStage,
      );
}
