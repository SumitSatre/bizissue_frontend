import 'package:flutter/material.dart';

class ScreenPadding extends StatelessWidget {
  final Widget child;
  final double? padding;
  const ScreenPadding({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: padding ?? 16),
      child: child,
    );
  }
}
