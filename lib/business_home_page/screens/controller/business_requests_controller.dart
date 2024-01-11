import 'dart:convert';

import 'package:bizissue/api%20repository/api_http_response.dart';
import 'package:bizissue/api%20repository/product_repository.dart';
import 'package:bizissue/business_home_page/models/request_user_model.dart';
import 'package:bizissue/utils/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';

class BusinessRequestsProvider extends ChangeNotifier{
  List<RequestUserModel>? _userRequestlist;
  List<RequestUserModel>? get userRequestlist => _userRequestlist;

  Future<List<RequestUserModel>> getRequestsList(String id) async {
    if (_userRequestlist == null) {
      print("This is id : $id");
      String accessToken = await SharedPreferenceService().getAccessToken();
      ApiHttpResponse response =
      await callUserGetMethod("business/get/request/${id}", accessToken);
      final data = jsonDecode(response.responceString!);
      debugPrint(data.toString());
      if (response.responseCode == 200) {
        print("This is data of users lists : ${data["data"]["users"]}");

        _userRequestlist = (data["data"]["requests"] as List)
            .map((item) => RequestUserModel.fromJson(item))
            .toList();

        notifyListeners();
        return _userRequestlist!;
      } else {
        // Handle the error case accordingly
        return []; // Or throw an exception, or handle it as needed
      }
    }

    // If _userlistModel is not null, return the cached list
    return _userRequestlist!;
  }
}