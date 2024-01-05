import 'package:flutter/material.dart';

class CustomChatButton extends StatelessWidget {
  const CustomChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // handle button press
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
          Icons.chat_bubble_outline,
          color: Colors.black,
          size: 20,
        ),
      ),
    );
  }
}
