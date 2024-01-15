import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ovpngate/core/lang/lang_en.dart';
import 'package:ovpngate/core/presentation/bloc/connected_server_cubit.dart';
import 'package:ovpngate/features/home/presentation/widgets/home_screen.dart';
import 'package:ovpngate/features/server%20list/data/data%20source/vpngate_remote_source.dart';
import 'package:ovpngate/features/server%20list/data/repository/vpngate_repository.dart';
import 'package:ovpngate/features/server%20list/presentation/bloc/server_list_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => VpngateRepository(
        remoteSource: VpngateRemoteSource(Dio()),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ServerListCubit(context.read<VpngateRepository>()),
          ),
          BlocProvider(
            create: (context) => ConnectedServerCubit(),
          ),
        ],
        child: MaterialApp(
          title: LangEN.homeTitle,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
