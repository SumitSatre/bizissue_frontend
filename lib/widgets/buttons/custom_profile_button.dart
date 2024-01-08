
import 'package:flutter/material.dart';

class CustomProfileButton extends StatelessWidget {
  const CustomProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // handle button press
       //  Navigator.pushNamed(context, ProfileScreen.routeName);
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
          Icons.person_2_outlined,
          color: Colors.black,
          size: 20,
        ),
      ),
    );
  }
}
