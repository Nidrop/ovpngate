import 'package:core/core.dart';
import 'package:flutter/material.dart';

class MirrorListView extends StatefulWidget {
  const MirrorListView({
    super.key,
  });

  @override
  State<MirrorListView> createState() => _MirrorListViewState();
}

class _MirrorListViewState extends State<MirrorListView> {
  final List<String> _list = [...ApiConstants.staticMirrorList];

  void onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final String item = _list.removeAt(oldIndex);
      _list.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      onReorder: onReorder,
      itemCount: _list.length,
      itemBuilder: (BuildContext context, int index) => ListTile(
        key: ValueKey(index),
        title: Text(_list[index]),
      ),
    );
  }
}
