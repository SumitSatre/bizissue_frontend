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

  GroupModel? _groupModel;
  GroupModel? get groupModel => _groupModel;

  List<GroupShortModel>? _userGroupslist;
  List<GroupShortModel>? get userGroupslist => _userGroupslist;

  List<IssueModel>? _groupIssuesList;
  List<IssueModel>? get groupIssuesList => _groupIssuesList;

  List<GroupIssue>? _groupSortedIssuesList ;
  List<GroupIssue>? get groupSortedIssuesList => _groupSortedIssuesList;

  bool _isFetching = false;
  bool get isFetching => _isFetching;

  bool _isError = false;
  bool get isError => _isError;

  CreateGroupResponseModel? _createGroupResponseModel ;
  CreateGroupResponseModel? get createGroupResponseModel => _createGroupResponseModel;

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
  Future<void> getGroupData(String id, String groupId) async {
    print("This is id : $id");
    String accessToken = await SharedPreferenceService().getAccessToken();
    ApiHttpResponse response = await callUserGetMethod(
        "group/get/group/${id}?groupId=${groupId}", accessToken);
    final data = jsonDecode(response.responceString!);
    debugPrint(data.toString());

    print("This is data of users lists 1");
    if (response.responseCode == 200){
      // print("This is data of users lists 2${data["data"]["issues"]}");

      _groupModel = GroupModel.fromJson(data["data"]);
      print("This is group model data ${_groupModel.toString()}");

      _groupIssuesList = (data["data"]["issues"] as List)
          .map((item) => IssueModel.fromJson(item))
          .toList();
      // print("data sorted is : ${groupIssuesList.toString()}");

      _groupSortedIssuesList = groupAndSortIssues(_groupIssuesList ?? []);
      print("data sorted is : ${groupSortedIssuesList.toString()}");
    } else {

    }
    notifyListeners();
  }

  void setIsFetching(bool val){
    _isFetching = val;
    notifyListeners();
  }

  void clearGroupPageData(){
    _userGroupslist = null;
  }

  void clearGroupViewData(){
    _groupIssuesList = null;
    _groupSortedIssuesList = null;
    // notifyListeners();
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

  Future<void> deleteGroupRequest(BuildContext context , String businessId) async {

    if(_groupModel == null && _groupModel!.groupId == null){
      showSnackBar(context, "Group is not valid", invalidColor);
      return;
    }

    String groupId = _groupModel!.groupId;

    String accessToken = await SharedPreferenceService().getAccessToken();
    ApiHttpResponse response = await callUserDeleteMethod(
        {},"group/delete/${businessId}/${groupId}", accessToken);
    final data = jsonDecode(response.responceString!);
    debugPrint(data.toString());

    // print("This is data of users lists 1");
    if (response.responseCode == 200){
      showSnackBar(context, "Group deleted successfully!!", successColor);
      GoRouter.of(context).pop();
    } else {

    }
    notifyListeners();
  }

}
