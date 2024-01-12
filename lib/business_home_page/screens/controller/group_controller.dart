import 'dart:convert';

import 'package:bizissue/api%20repository/api_http_response.dart';
import 'package:bizissue/api%20repository/product_repository.dart';
import 'package:bizissue/business_home_page/models/group_short_model.dart';
import 'package:bizissue/business_home_page/models/request_user_model.dart';
import 'package:bizissue/utils/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';

class GroupProvider extends ChangeNotifier{
  List<GroupShortModel>? _userGroupslist;
  List<GroupShortModel>? get userGroupslist => _userGroupslist;

  Future<List<GroupShortModel>> getGroupsList(String id) async {
    if (_userGroupslist == null) {
      print("This is id : $id");
      String accessToken = await SharedPreferenceService().getAccessToken();
      ApiHttpResponse response =
      await callUserGetMethod("group/get/${id}", accessToken);
      final data = jsonDecode(response.responceString!);
      debugPrint(data.toString());
      if (response.responseCode == 200) {
        print("This is data of users lists : ${data["data"]["groups"]}");

        _userGroupslist = (data["data"]["groups"] as List)
            .map((item) => GroupShortModel.fromJson(item))
            .toList();

        notifyListeners();
        return _userGroupslist!;
      } else {
        // Handle the error case accordingly
        return []; // Or throw an exception, or handle it as needed
      }
    }

    // If _userlistModel is not null, return the cached list
    return _userGroupslist!;
  }
}