import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bizissue/auth/screens/controllers/login_provider.dart';
import 'package:bizissue/auth/models/dropdown_lists.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import '../../utils/routes/app_route_constants.dart';
import '../../widgets/buttons/round_cornered_button.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textScale = MediaQuery.textScaleFactorOf(context);

    return Consumer<LoginProvider>(builder: (context, controller, child) {
      return Stack(
        children: [
          Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.02,
                  horizontal: width * 0.06,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.22),
                    Center(
                      child: Image.asset('assets/images/google_icon.png'),
                    ),
                    SizedBox(height: height * 0.02),
                    Center(
                      child: Text(
                        "Login to your account",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 22 * textScale,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    const Row(
                      children: [
                        SizedBox(width: 5),
                        Text(
                          "Contact Number",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.007),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 5),
                            Container(
                              height: 50,
                              width: width * 0.19,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  style: BorderStyle.solid,
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  icon: const Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  elevation: 4,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  value: controller.countryCodeController.text,
                                  onChanged: (code) {
                                    setState(() {
                                      controller.countryCodeController.text =
                                          code ?? '+91';
                                    });
                                  },
                                  items: countryCodesList
                                      .map<DropdownMenuItem<String>>((String s) {
                                    return DropdownMenuItem<String>(
                                      value: s,
                                      child: Text("  $s"),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: width * 0.01,
                        ),
                        SizedBox(
                          width: width * 0.66,
                          height: 50,
                          child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            initialValue: '',
                            onChanged: (value) {
                              controller.numberController.text = value ?? "";
                            },
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Colors.black12,
                                ),
                              ),
                              hintText: "Enter Contact Number",
                              hintStyle: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Colors.black12,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Colors.black12,
                                ),
                              ),
                            ),
                            cursorColor: Colors.black,
                            cursorHeight: 22,
                            cursorWidth: 1.8,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.03),
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.055,
                      child: ElevatedButton(
                        onPressed: () async {
                          await controller.sendOTP(context);
                        },
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(kprimaryColor),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Send otp",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don’t have an account?",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: width * 0.01),
                        InkWell(
                          onTap: () {
                            GoRouter.of(context).pushNamed(MyAppRouteConstants.signupRouteName);
                          },
                          child: const Text(
                            "Register Now",
                            style: TextStyle(
                              color: Color(0xffAD2F3B),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (controller.isSendingOTP) // Show circular progress indicator conditionally
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      );
    });
  }
}
