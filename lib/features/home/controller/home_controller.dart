import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovpngate/core/di/di.dart';
import 'package:ovpngate/core/domain/entity/server_info.dart';
import 'package:ovpngate/core/domain/entity/vpn_stage.dart';
import 'package:ovpngate/core/domain/repository/vpn_service.dart';
import 'package:ovpngate/features/shared_features/openvpn_service.dart';
import 'package:ovpngate/features/server_list/server_list_screen.dart';

part 'home_state.dart';
part 'home_handler.dart';
part 'server_info_async_notifier.dart';
