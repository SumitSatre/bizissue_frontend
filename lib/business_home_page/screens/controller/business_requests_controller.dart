import 'dart:convert';

import 'package:bizissue/api%20repository/api_http_response.dart';
import 'package:bizissue/api%20repository/product_repository.dart';
import 'package:bizissue/business_home_page/models/request_user_model.dart';
import 'package:bizissue/business_home_page/models/user_list_model.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/services/shared_preferences_service.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BusinessRequestsProvider extends ChangeNotifier{
  List<RequestUserModel>? _userRequestlist;
  List<RequestUserModel>? get userRequestlist => _userRequestlist;

  UserRoleModel? _userRoleModel;
  UserRoleModel? get userRoleModel => _userRoleModel;

  String? nameOfAssignToUser = null;

  Future<List<RequestUserModel>> getRequestsList(String id) async {
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
    // If _userlistModel is not null, return the cached list
    return _userRequestlist!;
  }
  void updateAssignTo(UserListModel? userListItem) {
    if(userListItem != null){
      if (_userRoleModel != null ) {
        _userRoleModel = _userRoleModel!.copyWith(
          parentId: userListItem.userId,
        );
        // print("${userListItem.toJson()}");
      } else {
        _userRoleModel = UserRoleModel(parentId: userListItem!.userId);
      }

      print("Parent id is : ${_userRoleModel?.parentId ?? "No user"}");
    }

    notifyListeners();
  }

  void updateRole(String? role){
    if (_userRoleModel != null ) {
      _userRoleModel = _userRoleModel!.copyWith(
        role: role,
      );
      // print("${userListItem.toJson()}");
    } else {
      _userRoleModel = UserRoleModel(role: role,);
    }
    print("Role is : ${_userRoleModel?.role ?? "No role"}");
    notifyListeners();
  }

  void acceptRequestPost(BuildContext context , String id) async {

    if(!areAllFieldsFilled()){
      showSnackBar(context, "Fill complete details!!", invalidColor);
      return;
    }
    String accessToken = await SharedPreferenceService().getAccessToken();

    print(jsonEncode(_userRoleModel!.toJson()));

    ApiHttpResponse response = await callUserPostMethod(
        _userRoleModel!.toJson(), 'business/add/user/${id}', accessToken);

    final data = jsonDecode(response.responceString!);

    if (response.responseCode == 200) {
      print("Hi this is worked");
      GoRouter.of(context).pop();
      showSnackBar(context, "Request accepted Successfully!!", successColor);
      _userRoleModel = null;
//     if (_userRequestlist != null) {
//       // Assuming id is the condition you want to use for removal
//
//       // Convert list to JSON using null-aware operator
//       List<Map<String, dynamic>> jsonList = _userRequestlist?.map((user) => user.toJson())?.toList() ?? [];
//
//       // Remove the item from the JSON list
//       jsonList.removeWhere((json) => json['id'] == id);
//
//       // Convert JSON list back to list of models using null-aware operator
//       _userRequestlist = jsonList?.map((json) => RequestUserModel.fromJson(json))?.toList() ?? [];
//     }
      notifyListeners();
    }
    debugPrint(response.responceString);
  }

  bool areAllFieldsFilled() {
    // Check if all required fields are filled and not empty
    return _userRoleModel != null &&
        _userRoleModel!.role != null &&
        _userRoleModel!.role!.isNotEmpty &&
        _userRoleModel!.parentId != null &&
        _userRoleModel!.parentId!.isNotEmpty &&
        _userRoleModel!.parentId != null &&
        _userRoleModel!.parentId!.isNotEmpty;
  }

  void setUserId(String userId){
    if (_userRoleModel != null ) {
      _userRoleModel = _userRoleModel!.copyWith(
        userId: userId,
      );
      // print("${userListItem.toJson()}");
    } else {
      _userRoleModel = UserRoleModel(userId: userId,);
    }
    print("Role is : ${_userRoleModel?.role ?? "No role"}");
    notifyListeners();
  }

  void clear(){
    _userRequestlist = null;
    _userRoleModel = null;
    notifyListeners();
  }
}

class UserRoleModel {
  final String? role;
  final String? parentId;
  final String? userId;

  UserRoleModel({
    this.role,
    this.parentId,
    this.userId,
  });

  factory UserRoleModel.fromJson(Map<String, dynamic> json) {
    return UserRoleModel(
      role: json['role'] ?? "",
      parentId: json['parentId'] ?? "",
      userId: json['userId'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'parentId': parentId,
      'userId': userId,
    }..removeWhere((key, value) => value == null);
  }

  UserRoleModel copyWith({
    String? role,
    String? parentId,
    String? userId,
  }) {
    return UserRoleModel(
      role: role ?? this.role,
      parentId: parentId ?? this.parentId,
      userId: userId ?? this.userId,
    );
  }
}
