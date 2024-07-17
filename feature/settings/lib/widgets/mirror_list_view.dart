import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:settings/bloc/settings_cubit.dart';

class MirrorListView extends StatelessWidget {
  const MirrorListView({
    super.key,
    required this.urls,
  });
  final List<String> urls;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      onReorder: context.read<SettingsCubit>().changeMirrorsOrder,
      itemCount: urls.length,
      itemBuilder: (BuildContext context, int index) => ListTile(
        key: ValueKey(index),
        title: Text(urls[index]),
      ),
    );
  }
}
