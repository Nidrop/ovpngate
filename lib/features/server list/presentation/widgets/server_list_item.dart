import 'package:flutter/material.dart';

class ServerListItem extends StatelessWidget {
  const ServerListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('JP'),
      title: Text('opengw.net'),
      subtitle: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('38 sessions'),
          SizedBox(
            width: 20,
          ),
          Text('14 days'),
        ],
      ),
      trailing: Text('117 MBps'),
    );
  }
}
