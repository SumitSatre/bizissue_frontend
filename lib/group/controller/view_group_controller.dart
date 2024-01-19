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

class ViewGroupProvider extends ChangeNotifier {
  GroupModel? _groupModel;
  GroupModel? get groupModel => _groupModel;

  List<IssueModel>? _groupIssuesList;
  List<IssueModel>? get groupIssuesList => _groupIssuesList;

  List<GroupIssue>? _groupSortedIssuesList;
  List<GroupIssue>? get groupSortedIssuesList => _groupSortedIssuesList;

  // these are for view multiple groups
  List<String>? groupIds;
  List<String>? groupNames;

  bool _isFetching = false;
  bool get isFetching => _isFetching;

  bool _isError = false;
  bool get isError => _isError;

  // here i have to make changes
  Future<void> getGroupData(String id, String groupId) async {
    print("This is id : $id");
    String accessToken = await SharedPreferenceService().getAccessToken();
    ApiHttpResponse response = await callUserGetMethod(
        "group/get/group/${id}?groupId=${groupId}", accessToken);
    final data = jsonDecode(response.responceString!);
    debugPrint(data.toString());

    print("This is data of users lists 1");
    if (response.responseCode == 200) {
      // print("This is data of users lists 2${data["data"]["issues"]}");

      _groupModel = GroupModel.fromJson(data["data"]);
      print("This is group model data ${_groupModel.toString()}");

      _groupIssuesList = (data["data"]["issues"] as List)
          .map((item) => IssueModel.fromJson(item))
          .toList();
      // print("data sorted is : ${groupIssuesList.toString()}");

      _groupSortedIssuesList = groupAndSortIssues(_groupIssuesList ?? []);
      print("data sorted is : ${groupSortedIssuesList.toString()}");
    } else {}
    notifyListeners();
  }

  Future<void> getMultipleGroupsData(String id, List<String> groupIds) async {
    print("This is id : $id");
    String accessToken = await SharedPreferenceService().getAccessToken();
    ApiHttpResponse response = await callUserGetMethod(
        "group/get/multiple/${id}?groupIds=${groupIds}", accessToken);
    final data = jsonDecode(response.responceString!);
    debugPrint(data.toString());

    print("This is data of users lists 1");
    if (response.responseCode == 200) {
      // print("This is data of users lists 2${data["data"]["issues"]}");

      //_groupModel = GroupModel.fromJson(data["data"]);
      print("This is group model data ${_groupIssuesList.toString()}");

      _groupIssuesList = (data["data"]["combinedIssues"] as List)
          .map((item) => IssueModel.fromJson(item))
          .toList();
      // print("data sorted is : ${groupIssuesList.toString()}");

      _groupSortedIssuesList = groupAndSortIssues(_groupIssuesList ?? []);
      print("data sorted is : ${groupSortedIssuesList.toString()}");
    } else {}
    notifyListeners();
  }

  void setIsFetching(bool val) {
    _isFetching = val;
    notifyListeners();
  }

  void clearGroupViewData() {
    _groupIssuesList = null;
    _groupSortedIssuesList = null;
    // notifyListeners();
  }

  Future<void> deleteGroupRequest(
      BuildContext context, String businessId) async {
    if (_groupModel == null && _groupModel!.groupId == null) {
      showSnackBar(context, "Group is not valid", invalidColor);
      return;
    }

    String groupId = _groupModel!.groupId;

    String accessToken = await SharedPreferenceService().getAccessToken();
    ApiHttpResponse response = await callUserDeleteMethod(
        {}, "group/delete/${businessId}/${groupId}", accessToken);
    final data = jsonDecode(response.responceString!);
    debugPrint(data.toString());

    // print("This is data of users lists 1");
    if (response.responseCode == 200) {
      showSnackBar(context, "Group deleted successfully!!", successColor);
      GoRouter.of(context).pop();
    } else {}
    notifyListeners();
  }
}
