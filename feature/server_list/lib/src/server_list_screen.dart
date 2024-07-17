import 'package:core/core.dart';
import 'package:core/localization/generated/locale_keys.g.dart';
import 'package:domain/models/server_info.dart';
import 'package:domain/repositories/i_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:server_list/src/bloc/server_list_cubit.dart';
import 'package:server_list/src/bloc/server_list_state.dart';
import 'package:server_list/src/server_list_content.dart';
import 'package:server_list/src/widgets/server_list_item.dart';

@RoutePage()
class ServerListScreen extends StatelessWidget {
  const ServerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServerListCubit(appLocator.get<IRepository>()),
      child: const ServerListContent(),
    );
  }
}
