import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:settings/src/bloc/settings_cubit.dart';

class MirrorListView extends StatelessWidget {
  const MirrorListView({
    super.key,
    required this.urls,
  });
  final List<String> urls;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      onReorder: context.read<SettingsCubit>().reorderMirrors,
      itemCount: urls.length,
      itemBuilder: (BuildContext context, int index) => ListTile(
        key: ValueKey(index),
        leading: (urls[index] != ApiConstants.staticMirrorList.first)
            ? IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  context.read<SettingsCubit>().deleteMirror(index);
                },
              )
            : null,
        title: Text(urls[index]),
      ),
    );
  }
}
