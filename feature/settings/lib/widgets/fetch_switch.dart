import 'package:core/core.dart';
import 'package:domain/models/settings.dart';
import 'package:flutter/material.dart';
import 'package:settings/bloc/settings_cubit.dart';

class FetchSwitch extends StatelessWidget {
  final FetchMode fetchMode;
  const FetchSwitch({
    super.key,
    required this.fetchMode,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: (fetchMode == FetchMode.html) ? true : false,
      onChanged: (val) => context.read<SettingsCubit>().changeFetch(val),
    );
  }
}
