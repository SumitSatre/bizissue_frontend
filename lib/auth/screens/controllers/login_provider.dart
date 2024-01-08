// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:bizissue/api%20repository/api_http_response.dart';
import 'package:bizissue/utils/services/shared_preferences_service.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../api repository/product_repository.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController countryCodeController =
  TextEditingController(text: "+91");
  final TextEditingController numberController = TextEditingController();
  final TextEditingController otpCodeController = TextEditingController();
  // String message = "";
  String _accessToken = "";
  bool _isRequestSent = false;

  bool get isRequestSent => _isRequestSent;

  Future<bool> login(BuildContext context) async {

    print("Number ${numberController.text}");

    if (numberController.text.isNotEmpty && numberController.text.length == 10) {
      String res = await sendLoginRequest();

      if (res == "Login request sent successfully") {
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

  Future<String> sendLoginRequest() async {
    String res = "Some error occurred";
    ApiHttpResponse response = await callPostMethod(
      {
        "contactNumber": {
          "countryCode": countryCodeController.text,
          "number": numberController.text,
        },
      },
      "auth/login",
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

  Future<bool> verifyLoginOtp(BuildContext context) async {

    if (numberController.text.isNotEmpty && numberController.text.length == 10) {
      if (otpCodeController.text.length == 6) {
        String res = await verifyLoginOtpRequest();

        if (res == "Login request for verification sent successfully") {
          SharedPreferenceService().setLogin(_accessToken);
          print("Done");
          return true;
        } else {
          showSnackBar(context, res, Colors.red);
          return false;
        }
      } else {
        showSnackBar(context, "Otp is not valid", Colors.red);
        Navigator.of(context).pop();
        return false;
      }
    } else {
      showSnackBar(context, "Please enter a valid contact number", Colors.red);
      Navigator.of(context).pop();
      return false;
    }
  }

  Future<String> verifyLoginOtpRequest() async {
    String res = "Some error occurred";
    ApiHttpResponse response = await callPostMethod(
      {
        "contactNumber": {
          "countryCode": countryCodeController.text,
          "number": numberController.text,
        },
        "otp": otpCodeController.text,
      },
      "auth/login/verify",
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
}
