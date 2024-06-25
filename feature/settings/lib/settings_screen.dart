import 'package:core/core.dart';
import 'package:core/localization/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr(LocaleKeys.common_settings)),
      ),
      body: Column(
        children: [
          Text('Theme'),
          SizedBox(
            height: 50,
            child: ThemeToggle(),
          ),
          Text('Fetch'),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('CSV'),
                Switch(value: false, onChanged: (val) {}),
                Text('HTML'),
              ],
            ),
          ),
          Text('Mirrors order'),
          Flexible(
            child: MirrorListView(),
          ),
        ],
      ),
    );
  }
}

class ThemeToggle extends StatefulWidget {
  const ThemeToggle({
    super.key,
  });

  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  final _isSelected = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: _isSelected,
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0;
              buttonIndex < _isSelected.length;
              buttonIndex++) {
            if (buttonIndex == index) {
              _isSelected[buttonIndex] = true;
            } else {
              _isSelected[buttonIndex] = false;
            }
          }
        });
      },
      children: const [
        Icon(Icons.phone_android),
        Icon(Icons.light_mode),
        Icon(Icons.dark_mode),
      ],
    );
  }
}

class MirrorListView extends StatefulWidget {
  const MirrorListView({
    super.key,
  });

  @override
  State<MirrorListView> createState() => _MirrorListViewState();
}

class _MirrorListViewState extends State<MirrorListView> {
  final List<String> _list = [...ApiConstants.staticMirrorList];

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final String item = _list.removeAt(oldIndex);
          _list.insert(newIndex, item);
        });
      },
      itemCount: ApiConstants.staticMirrorList.length,
      itemBuilder: (BuildContext context, int index) => ListTile(
        key: ValueKey(index),
        title: Text(_list[index]),
      ),
    );
  }
}
