import 'package:bizissue/widgets/buttons/round_cornered_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class OtpDialog extends StatelessWidget {
  final double height;
  final Function onCompleted;
  final Function onSubmit;

  OtpDialog({
    required this.height,
    required this.onCompleted,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Image(
              image: AssetImage("assets/images/google_icon.png"),
              height: 40,
              fit: BoxFit.fitHeight,
            ),
            SizedBox(height: 20),
            Text(
              "Enter Verification Code",
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "We sent a 6-digit code to your number",
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: height * 0.06,
              child: Pinput(
                length: 6,
                showCursor: true,
                onCompleted: (pin)=>onCompleted,
              ),
            ),
            SizedBox(height: 20),
            RoundCorneredButton(
              buttonText: "Submit",
              onClick: onSubmit(),
              on: true,
              width: 251,
            ),
          ],
        ),
      ),
    );
  }
}
