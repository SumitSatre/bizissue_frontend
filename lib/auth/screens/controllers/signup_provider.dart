// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:bizissue/api%20repository/api_http_response.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:bizissue/utils/services/shared_preferences_service.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../api repository/product_repository.dart';

class SignupProvider extends ChangeNotifier {
  final TextEditingController countryCodeController =
  TextEditingController(text: "+91");
  final TextEditingController numberController = TextEditingController();
  final TextEditingController otpCodeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  // String message = "";
  String _accessToken = "";
  bool _isRequestSent = false;

  bool isSendingOTP = false;

  bool get isRequestSent => _isRequestSent;

  Future<bool> signup(BuildContext context) async {

    if (numberController.text.isNotEmpty && numberController.text.length == 10 && nameController.text.isNotEmpty) {
      String res = await sendSignupRequest();

      print("response is : $res");
      if (res == "Login request sent successfully") {
        print("Done");
        return true;
      } else {
        showSnackBar(context, res, Colors.red);
        return false;
      }
    } else {
      showSnackBar(context, "Fill complete details!!", Colors.red) ;
      return false;
    }
  }

  Future<String> sendSignupRequest() async {
    String res = "Some error occurred";
    ApiHttpResponse response = await callPostMethod(
      {
        "contactNumber": {
          "countryCode": countryCodeController.text,
          "number": numberController.text,
        },
      },
      "auth/register",
    );

    final data = jsonDecode(response.responceString!);

    if (response.responseCode == 200) {
      _isRequestSent = true;
      notifyListeners();
      res = "Login request sent successfully";
    } else {
      res = data["message"];
    }

    return res;
  }

  Future<bool> verifySignupOtp(BuildContext context) async {

    if (numberController.text.isNotEmpty && numberController.text.length == 10 && nameController.text.isNotEmpty) {
        String res = await verifySignupOtpRequest();

        if (res == "Login request for verification sent successfully") {
          SharedPreferenceService().setLogin(_accessToken);
          print("Done");
          return true;
        } else {
          showSnackBar(context, res, Colors.red);
          return false;
        }
    } else {
      showSnackBar(context, "Please enter a valid contact number", Colors.red);
      return false;
    }
  }

  Future<String> verifySignupOtpRequest() async {
    String res = "Some error occurred";
    ApiHttpResponse response = await callPostMethod(
      {
        "contactNumber": {
          "countryCode": countryCodeController.text,
          "number": numberController.text,
        },
        "otp": "123456",
        "name" : nameController.text
      },
      "auth/register/verify",
    );

    final data = jsonDecode(response.responceString!);

    print("This is data : ${data}");

    if (response.responseCode == 200) {
      _accessToken = data["authToken"];
      notifyListeners();
      print(_accessToken);
      res = "Login request for verification sent successfully";
    } else {
      res = data["message"];
    }

    return res;
  }

  Future<void> sendOTP(BuildContext context) async {
    print("${countryCodeController.text}${numberController.text}");
    if (numberController.text.isEmpty && numberController.text.length != 10) {

      showSnackBar(context, "Please enter a valid contact number!!", Colors.red);
      return;
    }

    isSendingOTP = true;
    notifyListeners();

    String phoneNumber = "${countryCodeController.text}${numberController.text}";
    print("Number is : $phoneNumber");

    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Handle verification completed
          isSendingOTP = false;
        },
        verificationFailed: (FirebaseAuthException e) {
          isSendingOTP = false;
          notifyListeners();
          showSnackBar(context, "Unable to send OTP!!", Colors.red);
          print('Verification Failed: ${e.message}');
        },
        codeSent: (String verId, int? resendToken) async {
          isSendingOTP = false;
          GoRouter.of(context)
              .pushNamed(MyAppRouteConstants.verifySignUpRouteName, params: {
            'VerificationId': '${verId}'
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          isSendingOTP = false;
          notifyListeners();
          showSnackBar(context, "Unable to send OTP!!", Colors.red);
        },
      );
    } catch (e) {
      print('Error sending OTP: $e');
      showSnackBar(context, "Unable to send OTP, enter a valid number!!", Colors.red);
    }
  }

  Future<bool> verifyOTP(String verificationId, String smsCode) async {
    try {
      // Create a PhoneAuthCredential with the verification ID and SMS code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      // Sign in with the PhoneAuthCredential
      await FirebaseAuth.instance.signInWithCredential(credential);

      // The user is now signed in, you can handle the signed-in user as needed.
      print('OTP verification successful!');
      return true;
    } catch (e) {
      // Handle errors during OTP verification
      print('Error verifying OTP: $e');
      return false;
    }
  }

  void cancelVerification() {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '', // You can pass any non-empty string here
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: Duration(seconds: 0), // Set timeout to 0 to cancel verification immediately
    );
  }

}
