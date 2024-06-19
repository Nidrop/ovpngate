import 'package:domain/repositories/i_vpn_service.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';

abstract class OpenvpnMapper {
  static EnVPNStage vpnstageToEnvpnstage(VPNStage stage) {
    return EnVPNStage.values[stage.index];
  }
}
