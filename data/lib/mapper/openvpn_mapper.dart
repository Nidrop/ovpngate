import 'package:core/core.dart';
import 'package:domain/repositories/i_vpn_service.dart';

abstract class OpenvpnMapper {
  static EnVPNStage vpnstageToEnvpnstage(VPNStage stage) {
    return EnVPNStage.values[stage.index];
  }
}
