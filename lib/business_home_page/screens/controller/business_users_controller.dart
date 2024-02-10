import 'dart:convert';

import 'package:bizissue/Issue/models/issue_model.dart';
import 'package:bizissue/api%20repository/api_http_response.dart';
import 'package:bizissue/api%20repository/product_repository.dart';
import 'package:bizissue/business_home_page/models/business_model.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:bizissue/business_home_page/models/user_record_model.dart'; // Make sure to import UserRecord model
import 'package:bizissue/utils/services/shared_preferences_service.dart';
import 'package:bizissue/utils/utils.dart';

class BusinessUsersProvider extends ChangeNotifier {
  List<UserRecord>? usersList;

  bool _isFetching = false;
  bool get isFetching => _isFetching;

  List<IssueModel>? myIssues;
  List<IssueModel>? myTeamIssues;

  List<GroupIssue>? _myIssuesGroup;
  List<GroupIssue>? get myIssuesGroup => _myIssuesGroup;

  List<GroupIssue>? _myTeamIssuesGroup;
  List<GroupIssue>? get myTeamIssuesGroup => _myTeamIssuesGroup;

  Future<void> getUsersInBusiness(BuildContext context, String id) async {
    print("This is id : $id");
    String accessToken = await SharedPreferenceService().getAccessToken();
    ApiHttpResponse response =
        await callUserGetMethod("business/get/all/users/${id}", accessToken);
    final data = jsonDecode(response
        .responceString!); // Corrected "responceString" to "responseString"
    debugPrint(data.toString());
    if (response.responseCode == 200) {
      print("This is data of users lists : ${data["data"]["users"]}");

      usersList = (data["data"]["users"] as List)
          .map((item) => UserRecord.fromJson(item))
          .toList();

      // if there are no users in the list
      if (usersList == null) {
        usersList = [];
      }
    } else {
      usersList = [];
      showSnackBar(context, "Unable to fetch requests list!!", failureColor);
    }
    notifyListeners();
    // If _userlistModel is not null, return the cached list
  }

  void promoteDemoteUserRequest(BuildContext context, String businessId,
      String role, String userIdToPromote) async {
    try {
      // Validate business code
      print("Hiiiii");
      if (businessId == null || businessId.isEmpty) {
      //  showSnackBar(context, "Invalid business code!!", invalidColor);
        return;
      }

      if (role == null ||
          role.isEmpty ||
          userIdToPromote == null ||
          userIdToPromote.isEmpty) {
       // showSnackBar(context, "Invalid business role and userIdToPromote!!",
       //     invalidColor);
        return;
      }

      String accessToken = await SharedPreferenceService().getAccessToken();

      ApiHttpResponse response = await callUserPatchMethod({
        "role": role,
        "userIdToPromote" : userIdToPromote
      }, 'business/promotion/${businessId}', accessToken);

      if (response.responseCode == 200) {
      //  showSnackBar(context, "User promoted successfully!!", successColor);
        print("Done");
        updateRole(userIdToPromote , role);
        notifyListeners();
      } else {
        final data = jsonDecode(response.responceString ?? "");

        // Handle other status codes if needed
     //   showSnackBar(
     //       context,
     //       "Failed to send promotion request to business: ${data['message']}",
       //     invalidColor);
      }

      debugPrint(response.responceString);
    } catch (e) {
      // Handle unexpected errors
    //  showSnackBar(context, "An unexpected error occurred", invalidColor);
      print("Error: $e");
    }
    setFetching(false);
  }

  void setFetching(bool val) {
    _isFetching = val;
    notifyListeners();
  }

  void updateRole(String userId, String newRole) {
    // Check if usersList is not null and not empty
    print("This is index ");
    if (usersList != null && usersList!.isNotEmpty) {
      // Find the index of the user with the matching userId
      int index = usersList!.indexWhere((user) => user.userId == userId);

      print("This is index $index");
      // If user with userId is found, update their role
      if (index != -1) {
        usersList![index].role = newRole; // Update the role directly
        // Call notifyListeners() to rebuild widgets listening to this provider
        notifyListeners();
      }
    }
  }

  Future<void> getClosedIssueRequest(String id) async {
    print("This is id : $id");
    String accessToken = await SharedPreferenceService().getAccessToken();
    ApiHttpResponse response =
    await callUserGetMethod("business/get/closed/issues/${id}", accessToken);
    final data = jsonDecode(response.responceString!);
    debugPrint(data.toString());
    if (response.responseCode == 200) {
      // print("This is data ${data["data"]}");
      myIssues = (data["data"]["myIssues"] as List)
          .map((item) => IssueModel.fromJson(item))
          .toList();
      myTeamIssues = (data["data"]["myTeamIssues"] as List)
          .map((item) => IssueModel.fromJson(item))
          .toList();
      _myIssuesGroup = groupAndSortIssues(myIssues ?? []);
      _myTeamIssuesGroup =
          groupAndSortIssues(myTeamIssues ?? []);
      print("Done");
      notifyListeners();
    } else {
      _myIssuesGroup = [];
      _myTeamIssuesGroup = [];
      notifyListeners();
    }
  }

  void sortAccordingToDeliveryDate(){
    _myIssuesGroup = groupAndSortIssuesDeliveryDate(myIssues ?? []);
    _myTeamIssuesGroup =
        groupAndSortIssuesDeliveryDate(myTeamIssues ?? []);
  }

  void sortAccordingToNextFollowUpDate(){
    _myIssuesGroup = groupAndSortIssues(myIssues ?? []);
    _myTeamIssuesGroup =
        groupAndSortIssues(myTeamIssues ?? []);
  }


}
