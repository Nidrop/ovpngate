import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovpngate/core/di/di.dart';
import 'package:ovpngate/core/domain/entity/server_info.dart';
import 'package:ovpngate/core/domain/entity/vpn_stage.dart';
import 'package:ovpngate/core/domain/repository/vpn_repository.dart';
import 'package:ovpngate/core/domain/repository/vpn_service.dart';
import 'package:ovpngate/features/server_list/widgets/disconnect_alert_dialog.dart';

part 'server_list_state.dart';
part 'server_list_handler.dart';
part 'server_list_async_notifier.dart';
