import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final VoidCallback onClick;
  final IconData icon;
  const RoundIconButton({super.key, required this.onClick, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(icon),
      ),
    );
  }
}
