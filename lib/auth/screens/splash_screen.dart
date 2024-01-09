import 'dart:async';
import 'package:bizissue/utils/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bizissue/utils/colors.dart';

import '../../utils/routes/app_route_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextPage();
  }

  void navigateToNextPage() async {
    Future.delayed(
      const Duration(seconds: 4),
    );
    SharedPreferenceService().checkLogin().then((value) async {
      if (value) {
        print("Authtoken");
        GoRouter.of(context)
            .goNamed(MyAppRouteConstants.homeRouteName);
      } else {
        print("No Authtoken");
        GoRouter.of(context)
            .goNamed(MyAppRouteConstants.loginRouteName);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textScale = MediaQuery.textScaleFactorOf(context);
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Onboarding_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.06,
            ),
            Text(
              'Welcome to',
              style: TextStyle(
                color: Colors.black,
                fontSize: 32 * textScale,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            SizedBox(
              width: width * 0.5,
              height: height * 0.2,
              child: const Image(
                image: AssetImage('assets/images/google_icon.png'),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: width * 0.75,
              height: height * 0.13,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'BizIssue',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sansitaSwashed(
                    color: kprimaryColor,
                    fontSize: 65 * textScale,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: width * 0.73,
              height: height * 0.06,
              child: Text(
                'Manage Business Effectively',
                textAlign: TextAlign.center,
                style: GoogleFonts.sansitaSwashed(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3.98,
                ),
              ),
            ),
            Container(
              width: width * 0.53,
              height: height * 0.38,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Onboarding_picture.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
