import 'dart:convert';

import 'package:bizissue/api%20repository/api_http_response.dart';
import 'package:bizissue/api%20repository/product_repository.dart';
import 'package:bizissue/business_home_page/models/request_user_model.dart';
import 'package:bizissue/business_home_page/models/user_list_model.dart';
import 'package:bizissue/home/models/user_model.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/services/shared_preferences_service.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BusinessRequestsProvider extends ChangeNotifier{
  List<RequestUserModel>? userRequestlist;

  UserRoleModel? userRoleModel;

  String? nameOfAssignToUser = null;

  Future<void> getRequestsList(BuildContext context , String id) async {
      print("This is id : $id");
      String accessToken = await SharedPreferenceService().getAccessToken();
      ApiHttpResponse response =
      await callUserGetMethod("business/get/request/${id}", accessToken);
      final data = jsonDecode(response.responceString!);
      debugPrint(data.toString());
      if (response.responseCode == 200) {
        print("This is data of users lists : ${data["data"]["users"]}");

        userRequestlist = (data["data"]["requests"] as List)
            .map((item) => RequestUserModel.fromJson(item))
            .toList();

        // if their is no request in the business
        if(userRequestlist == null){
          userRequestlist = [];
        }

      } else {
        userRequestlist = [];
        showSnackBar(context, "Unable to fetch requests list!!", failureColor);
      }
      notifyListeners();
    // If _userlistModel is not null, return the cached list
  }
  void updateAssignTo(UserListModel? userListItem) {
    if(userListItem != null){
      if (userRoleModel != null ) {
        userRoleModel = userRoleModel!.copyWith(
          parentId: userListItem.userId,
        );
        // print("${userListItem.toJson()}");
      } else {
        userRoleModel = UserRoleModel(parentId: userListItem!.userId);
      }

      print("Parent id is : ${userRoleModel?.parentId ?? "No user"}");
    }

    notifyListeners();
  }

  void updateRole(String? role){
    if (userRoleModel != null ) {
      userRoleModel = userRoleModel!.copyWith(
        role: role,
      );
      // print("${userListItem.toJson()}");
    } else {
      userRoleModel = UserRoleModel(role: role,);
    }
    print("Role is : ${userRoleModel?.role ?? "No role"}");
    notifyListeners();
  }

  void acceptRequestPost(BuildContext context , String id) async {

    if(!areAllFieldsFilled()){
      showSnackBar(context, "Fill complete details!!", invalidColor);
      return;
    }
    String accessToken = await SharedPreferenceService().getAccessToken();

    print(jsonEncode(userRoleModel!.toJson()));

    ApiHttpResponse response = await callUserPostMethod(
        userRoleModel!.toJson(), 'business/add/user/${id}', accessToken);

    final data = jsonDecode(response.responceString!);

    if (response.responseCode == 200) {
      print("Hi this is worked");
      GoRouter.of(context).pop();
      showSnackBar(context, "Request accepted Successfully!!", successColor);
      removeUserByIdFromRequestList(userRoleModel?.userId ?? "");
      userRoleModel = null;
      notifyListeners();
    }
    debugPrint(response.responceString);
  }

  Future<void> rejectRequestPost(BuildContext context , String businessId , String name ,ContactNumber contactNumber , String userId , String reason) async {

    String accessToken = await SharedPreferenceService().getAccessToken();
print("hiii");

    ApiHttpResponse response = await callUserPostMethod(
        {
          "name" : name,
          "userId" : userId,
          "reason" : reason,
          "contactNumber" : {
            "countryCode" : contactNumber.countryCode,
            "number" : contactNumber.number
          }
        }
    , 'business/decline/request/${businessId}', accessToken);

    final data = jsonDecode(response.responceString!);

    print("This is response : $data");

    if (response.responseCode == 200) {
      // print("Hi this is worked");
      showSnackBar(context, "Request rejected Successfully!!", successColor);

      removeUserByIdFromRequestList(userId);
    }
    else{
      showSnackBar(context, "Unable to reject request!!", failureColor);
    }

    notifyListeners();
    debugPrint(response.responceString);
  }

  List<RequestUserModel>? removeUserByIdFromRequestList(String userId) {
    if (userRequestlist == null || userId == "") {
      print("User request list is empty.");
      return userRequestlist;
    }

    int indexToRemove = -1;
    for (int i = 0; i < userRequestlist!.length; i++) {
      if (userRequestlist![i].userId == userId) {
        indexToRemove = i;
        break;
      }
    }

    if (indexToRemove != -1) {
      userRequestlist!.removeAt(indexToRemove);
      print("User with userId: $userId removed successfully.");
      return userRequestlist;
    } else {
      print("User with userId: $userId not found.");
      return userRequestlist;
    }
  }

  bool areAllFieldsFilled() {
    // Check if all required fields are filled and not empty
    return userRoleModel != null &&
        userRoleModel!.role != null &&
        userRoleModel!.role!.isNotEmpty &&
        userRoleModel!.parentId != null &&
        userRoleModel!.parentId!.isNotEmpty &&
        userRoleModel!.parentId != null &&
        userRoleModel!.parentId!.isNotEmpty;
  }

  void setUserId(String userId){
    if (userRoleModel != null ) {
      userRoleModel = userRoleModel!.copyWith(
        userId: userId,
      );
      // print("${userListItem.toJson()}");
    } else {
      userRoleModel = UserRoleModel(userId: userId,);
    }
    print("Role is : ${userRoleModel?.role ?? "No role"}");
    notifyListeners();
  }

  void clear(){
    userRequestlist = null;
    userRoleModel = null;
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
