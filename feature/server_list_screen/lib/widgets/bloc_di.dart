import 'package:core/di/app_di.dart';
import 'package:domain/repositories/i_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:server_list_screen/bloc/server_list_cubit.dart';

class BlocDI extends StatelessWidget {
  const BlocDI({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ServerListCubit(appLocator.get<IRepository>()),
        ),
      ],
      child: child,
    );
  }
}
