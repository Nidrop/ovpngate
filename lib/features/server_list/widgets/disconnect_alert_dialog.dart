import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovpngate/core/di/di.dart';

class DisconnectAlertDialog extends ConsumerWidget {
  const DisconnectAlertDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(langProvider);

    return AlertDialog(
      title: Text(lang.areYouSureYouWantToContinue),
      // titleTextStyle: TextStyle(
      //   fontWeight: FontWeight.bold,
      //   color: Colors.black,
      //   fontSize: 20,
      // ),
      // actionsOverflowButtonSpacing: 20,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text(lang.no),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text(lang.yes),
        ),
      ],
      content: Text(lang.yourCurrentSessionWillBeTerminated),
    );
  }
}
