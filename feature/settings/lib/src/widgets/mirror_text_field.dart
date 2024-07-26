import 'package:flutter/material.dart';

class MirrorTextField extends StatefulWidget {
  const MirrorTextField({
    super.key,
    required this.onSubmitted,
  });
  final Function(String) onSubmitted;

  @override
  State<MirrorTextField> createState() => _MirrorTextFieldState();
}

class _MirrorTextFieldState extends State<MirrorTextField> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller.text = 'http://';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            onSubmitted: (value) {
              _submit(_controller, widget.onSubmitted);
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            _submit(_controller, widget.onSubmitted);
          },
        ),
      ],
    );
  }
}

void _submit(TextEditingController c, Function(String) f) {
  final s = _convertToUrl(c.text);
  c.text = 'http://';
  f(s);
}

String _convertToUrl(String value) {
  String res = value.trim();
  if (!res.startsWith(RegExp(r'https?://'))) {
    res = 'http://$res';
  }
  if (!res.endsWith('/')) {
    res = '$res/';
  }
  return res;
}
