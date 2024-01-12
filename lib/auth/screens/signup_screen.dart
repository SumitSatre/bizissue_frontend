import 'package:bizissue/auth/models/dropdown_lists.dart';
import 'package:bizissue/auth/screens/controllers/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/routes/app_route_constants.dart';
import '../../widgets/buttons/round_cornered_button.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textScale = MediaQuery.textScaleFactorOf(context);

    final controller = Provider.of<SignupProvider>(context, listen: false);

    return Scaffold(

      appBar : PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1E000000),
                      blurRadius: 4,
                      offset: Offset(-3, 3),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),




      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height * .02,
            horizontal: width * .06,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.10),
              Center(
                child: Image.asset('assets/images/google_icon.png'),
              ),
              SizedBox(height: height * 0.02),
              Center(
                child: Text(
                  "Create your account",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 22 * textScale,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: height * 0.03), // *** More space lefted ***
              const Row(
                children: [
                  SizedBox(width: 5),
                  Text(
                    "Name",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),
              SizedBox(
                height: 50,
                child: TextFormField(
                  initialValue: '',
                  onChanged: (value) {
                    controller.nameController.text = value ?? "";
                  },
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Colors.black12,
                      ),
                    ),
                    hintText: "Enter Name ",
                    hintStyle: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.grey.shade600),
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
              SizedBox(height: height * 0.01),
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
                            borderRadius: BorderRadius.circular(12)),
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
                                color: Colors.black, fontSize: 14),
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
                        LengthLimitingTextInputFormatter(
                            10), // Limits input to 10 characters
                        FilteringTextInputFormatter
                            .digitsOnly, // Allows only digits
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
                            color: Colors.grey.shade600),
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
                    bool result = await controller.signup(context);

                    if (result) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
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
                                          Navigator.of(context).pop();
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Image(
                                    image: AssetImage(
                                        "assets/images/google_icon.png"),
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
                                      onCompleted: (pin) {
                                        controller.otpCodeController.text =
                                            (pin == null) ? '' : pin.toString();
                                        print("This is $pin");
                                      },
                                      onChanged: (value) {},
                                    ),
                                  ),
                                  //Container(
                                  //  alignment: Alignment.centerLeft,
                                  //  child: CupertinoButton(
                                  //    onPressed: () {},
                                  //    child: Text(
                                  //      "Request new code",
                                  //      style: TextStyle(
                                  //        fontFamily: "Poppins",
                                  //        height: 1.5,
                                  //        color: Color(0XFFAD2F3B),
                                  //      ),
                                  //    ),
                                  //  ),
                                  //),
                                  SizedBox(height: 20),
                                  RoundCorneredButton(
                                    buttonText: "Submit",
                                    onClick: () async {
                                      bool result = await controller
                                          .verifySignupOtp(context);
                                      if (result) {
                                        GoRouter.of(context).pop();
                                        GoRouter.of(context).goNamed(MyAppRouteConstants.homeRouteName);
                                      }
                                    },
                                    on: true,
                                    width: 251,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }

                    // result ended
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(kprimaryColor),
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
            ],
          ),
        ),
      ),
    );
  }
}
