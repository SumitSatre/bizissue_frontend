import 'package:flutter/material.dart';

class RoundCorneredButton extends StatelessWidget {
  final VoidCallback onClick;
  final buttonText;
  final on ;
  final double width ;
  const RoundCorneredButton({super.key, required this.onClick , required this.buttonText , required this.on , this.width = 140 });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: width,
      child: ElevatedButton(
        onPressed : onClick,
        style:
        ButtonStyle(
          backgroundColor: on == true ? MaterialStateProperty.all<Color>(Color(0xFFAD2F3B)) : MaterialStateProperty.all<Color>(Colors.white),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
            fontSize: 12,
            color: on ? Colors.white : Color(0xFFAD2F3B),
          ),
        )
        ),
    );
  }
}
