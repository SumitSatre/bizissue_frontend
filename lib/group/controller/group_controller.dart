import 'dart:convert';

import 'package:bizissue/Issue/models/issue_model.dart';
import 'package:bizissue/api%20repository/api_http_response.dart';
import 'package:bizissue/api%20repository/product_repository.dart';
import 'package:bizissue/business_home_page/models/group_short_model.dart';
import 'package:bizissue/business_home_page/models/request_user_model.dart';
import 'package:bizissue/group/models/group_model.dart';
import 'package:bizissue/group/models/models.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/services/shared_preferences_service.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GroupProvider extends ChangeNotifier {

  List<GroupShortModel>? _userGroupslist;
  List<GroupShortModel>? get userGroupslist => _userGroupslist;

  bool _isFetching = false;
  bool get isFetching => _isFetching;

  bool _isError = false;
  bool get isError => _isError;

  CreateGroupResponseModel? _createGroupResponseModel ;
  CreateGroupResponseModel? get createGroupResponseModel => _createGroupResponseModel;

  List<GroupUsersIdModel>? groupUsersIds = null;

  final nameController = TextEditingController();

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

  // here i have to make changes

  Future<void> getGroupsWithIdsList(String businessId) async {
    if (_userGroupslist != null) {
      // Return if the data is already loaded
      return;
    }

    print("This is id : $businessId");
    String accessToken = await SharedPreferenceService().getAccessToken();
    ApiHttpResponse response =
    await callUserGetMethod("group/get/users/ids/$businessId", accessToken);

    final data = jsonDecode(response.responceString!);
    debugPrint(data.toString());

    if (response.responseCode == 200) {
      print("This is data of users lists : ${data["data"]["groups"]}");

      groupUsersIds = (data["data"]["groups"] as List)
          .map((item) => GroupUsersIdModel.fromJson(item))
          .toList();

      notifyListeners();
    } else {
      // Handle the error case accordingly
    }
  }


  void setIsFetching(bool val){
    _isFetching = val;
    notifyListeners();
  }

  void clearGroupPageData(){
    _userGroupslist = null;
  }

  void updateSelectedUsers(List<String> selectedUsers){
    print("These are selected useers : ${selectedUsers.toString()}");
    if (_createGroupResponseModel != null) {
      _createGroupResponseModel = _createGroupResponseModel!.copyWith(
        usersToAddIds:selectedUsers,
      );
    } else {
      _createGroupResponseModel = CreateGroupResponseModel( usersToAddIds:selectedUsers);
    }
    notifyListeners();
  }

  void updateGroupName(String? name) {
    if (_createGroupResponseModel != null) {
      _createGroupResponseModel = _createGroupResponseModel!.copyWith(
        name : name,
      );
    } else {
      _createGroupResponseModel = CreateGroupResponseModel(name: name);
    }
    notifyListeners();
  }

  void createGroupRequest(BuildContext context , String businessId) async {

    if(!_areAllFieldsFilledOfCreateGroup()){
      showSnackBar(context, "Fill complete details!!", invalidColor);
      return;
    }
    print("Done");
    String accessToken = await SharedPreferenceService().getAccessToken();

    print(jsonEncode(_createGroupResponseModel!.toJson()));

    ApiHttpResponse response = await callUserPostMethod(
        _createGroupResponseModel!.toJson(), 'group/create/${businessId}', accessToken);

    final data = jsonDecode(response.responceString!);

    if (response.responseCode == 200) {
      showSnackBar(context, "Group created Successfully!!", successColor);
      setCreateGroupVariablesNull();
    }
    else{
      showSnackBar(context, "Unable to create group!!", failureColor);
    }
    debugPrint(response.responceString);
    notifyListeners();
  }

  bool _areAllFieldsFilledOfCreateGroup() {
    // Check if all required fields are filled and not empty
    return _createGroupResponseModel != null &&
        _createGroupResponseModel!.name != null &&
        _createGroupResponseModel!.name!.isNotEmpty &&
        _createGroupResponseModel!.usersToAddIds != null;
  }

  void setCreateGroupVariablesNull(){
    _createGroupResponseModel = null;
    nameController.clear();
  }
}
