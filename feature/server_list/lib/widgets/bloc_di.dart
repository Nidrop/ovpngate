import 'package:core/core.dart';
import 'package:domain/repositories/i_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:server_list/bloc/server_list_cubit.dart';

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
