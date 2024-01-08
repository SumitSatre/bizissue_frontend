import 'package:flutter/material.dart';

class CustomMenuButton extends StatelessWidget {
  const CustomMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // handle button press
        Scaffold.of(context).openDrawer();
      },
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black54.withOpacity(0.10),
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
        ),
        child: const Icon(
          Icons.menu,
          color: Colors.black,
          size: 26,
        ),
      ),
    );
  }
}
