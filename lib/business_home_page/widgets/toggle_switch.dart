import 'package:flutter/material.dart';

class ToggleSwitch extends StatefulWidget {
  final bool isSwitched;

  ToggleSwitch({required this.isSwitched});

  @override
  _ToggleSwitchState createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  late bool isSwitched;

  @override
  void initState() {
    super.initState();
    isSwitched = widget.isSwitched;
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isSwitched,
      onChanged: (value) {
        setState(() {
          isSwitched = value;
        });
      },
    );
  }
}