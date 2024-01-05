import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      selectedItemColor: const Color(0xffAD2F3B),
      unselectedItemColor: Colors.black,
      unselectedLabelStyle: const TextStyle(
          color: Colors.black,
          fontFamily: "Poppins",
          letterSpacing: 1.0,
          fontWeight: FontWeight.w500),
      selectedLabelStyle: const TextStyle(
          fontFamily: "Poppins",
          letterSpacing: 1.0,
          fontWeight: FontWeight.w500,
          color: Color(0xffAD2F3B)),
      iconSize: 28,
      elevation: 35,
      unselectedFontSize: 12,
      selectedFontSize: 12,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.house_alt,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.doc,
          ),
          label: "Portfolio",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.bag,
          ),
          label: "Opportunities",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.signal_cellular_alt,
          ),
          label: "SKill Dev",
        ),
      ],
    );
  }
}
