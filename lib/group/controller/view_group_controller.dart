import 'dart:convert';
import 'package:bizissue/Issue/models/issue_model.dart';
import 'package:bizissue/api%20repository/api_http_response.dart';
import 'package:bizissue/api%20repository/product_repository.dart';
import 'package:bizissue/business_home_page/models/group_short_model.dart';
import 'package:bizissue/business_home_page/models/user_list_model.dart';
import 'package:bizissue/business_home_page/widgets/accpet_request_dialog.dart';
import 'package:bizissue/group/models/group_model.dart';
import 'package:bizissue/group/models/models.dart';
import 'package:bizissue/group/widgets/user_selection_group_dialog.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/services/shared_preferences_service.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ViewGroupProvider extends ChangeNotifier {
  GroupModel? _groupModel;
  List<IssueModel>? groupIssuesList;
  List<GroupIssue>? groupSortedIssuesList;

  List<String>? groupIds;
  List<String>? groupNames;

  bool _isFetching = false;
  bool _isError = false;

  setGroupDetailsNull() {
    groupIssuesList = null;
    groupSortedIssuesList = null;
  }

  Future<void> getGroupData(String id, String groupId) async {
    try {
      setFetching(true);
      final accessToken = await SharedPreferenceService().getAccessToken();
      final response = await callUserGetMethod(
          "group/get/group/${id}?groupId=${groupId}", accessToken);
      final data = jsonDecode(response.responceString!);
      handleResponse(response, () {
        _groupModel = GroupModel.fromJson(data!["data"]);
        groupSortedIssuesList = groupAndSortIssues(_groupModel?.issues ?? []);
      });
    } catch (e) {
      handleError(e);
    } finally {
      setFetching(false);
      notifyListeners();
    }
  }

  Future<void> getMultipleGroupsData(
      BuildContext context, String id, List<String> groupIds) async {
    try {
      print("These are ${groupIds}");
      setFetching(true);
      final accessToken = await SharedPreferenceService().getAccessToken();
      final response = await callUserPostMethod(
          {"groupIds": groupIds}, "group/get/multiple/${id}", accessToken);
      final data = jsonDecode(response.responceString!);
      handleResponse(response, () {
        groupIssuesList = (data["data"]["combinedIssues"] as List)
            .map((item) => IssueModel.fromJson(item))
            .toList();
        groupSortedIssuesList = groupAndSortIssues(groupIssuesList ?? []);
      });
    } catch (e) {
      handleError(e, context);
    } finally {
      setFetching(false);
      notifyListeners();
    }
  }

  Future<void> deleteGroupRequest(
      BuildContext context, String businessId) async {
    try {
      if (_groupModel == null || _groupModel!.groupId == null) {
        showSnackBar(context, "Group is not valid", invalidColor);
        return;
      }

      setFetching(true);
      final groupId = _groupModel!.groupId;
      final accessToken = await SharedPreferenceService().getAccessToken();
      final response = await callUserDeleteMethod(
          {}, "group/delete/$businessId/$groupId", accessToken);
      handleResponse(response, () {
        showSnackBar(context, "Group deleted successfully!!", successColor);
        GoRouter.of(context).pop();
      });
    } catch (e) {
      handleError(e, context);
    } finally {
      setFetching(false);
      notifyListeners();
    }
  }

  Future<void> removeUsersFromGroupRequest(BuildContext context,
      String businessId, List<String> usersToRemoveIds) async {
    try {
      if (_groupModel == null || _groupModel!.groupId == null) {
        showSnackBar(context, "Group is not valid", invalidColor);
        return;
      }

      setFetching(true);
      final groupId = _groupModel!.groupId;
      final accessToken = await SharedPreferenceService().getAccessToken();
      final response = await callUserPutMethod(
          {"usersToRemoveIds": usersToRemoveIds},
          "group/remove/users/$businessId/${_groupModel!.groupId}",
          accessToken);
      if (response.responseCode == 200) {
        // This snackBar is not working
        // showSnackBar(context, "Users removed from group successfully!!", successColor);
      }
    } catch (e) {
      handleError(e, context);
    } finally {
      setFetching(false);
      notifyListeners();
    }
  }

  Future<void> addUsersToGroupRequest(BuildContext context,
      String businessId, List<String> usersToAddIds) async {
    try {
      if (_groupModel == null || _groupModel!.groupId == null) {
        showSnackBar(context, "Group is not valid", invalidColor);
        return;
      }

      setFetching(true);
      final groupId = _groupModel!.groupId;
      final accessToken = await SharedPreferenceService().getAccessToken();
      final response = await callUserPutMethod(
          {"usersToAddIds": usersToAddIds},
          "group/add/users/$businessId/${_groupModel!.groupId}",
          accessToken);
      if (response.responseCode == 200) {
        // This snackBar is not working
        // showSnackBar(context, "Users added from group successfully!!", successColor);
      }
    } catch (e) {
      handleError(e, context);
    } finally {
      setFetching(false);
      notifyListeners();
    }
  }


  void handleResponse(ApiHttpResponse response, Function successCallback) {
    if (response.responseCode == 200) {
      successCallback();
    } else {
      throw Exception("API request failed with code ${response.responseCode}");
    }
  }

  void handleError(dynamic error, [BuildContext? context]) {
    _isError = true;
    // Handle specific errors if needed
    print("Error: $error");
    if (context != null) {
      showSnackBar(context, "An error occurred", errorColor);
    }
  }

  void setFetching(bool val) {
    _isFetching = val;
  }

  void clearGroupViewData() {
    groupIssuesList = null;
    _groupModel = null;
    groupSortedIssuesList = null;
  }

  void handleOnClickRemoveUsers(BuildContext context) async {
    if (context == null || !Navigator.canPop(context)) return;

    setFetching(true);
    final homeController = Provider.of<HomeProvider>(context, listen: false);

    Future<void> processGroupUsers(List<UserListModel> groupUsers) async {
      if (context == null || !Navigator.canPop(context)) return;

      print(groupUsers);
      setFetching(false);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return UserSelectionGroupDialog(
            userList: groupUsers,
            selectedOptions: [],
            onSelectionChanged: (List<String> selectedOptions) {
              removeUsersFromGroupRequest(
                  context, homeController.selectedBusiness, selectedOptions);
            },
          );
        },
      );
    }

    if (homeController.userlistModel == null) {
      await homeController.getUsersList().then((_) {
        processGroupUsers(
          selectUsersByIds(
            homeController.userlistModel ?? [],
            _groupModel?.usersIds ?? [],
          ),
        );
      });
    } else {
      processGroupUsers(
        selectUsersByIds(
          homeController.userlistModel ?? [],
          _groupModel?.usersIds ?? [],
        ),
      );
    }
  }

  void handleOnClickAddUsers(BuildContext context) async {
    if (context == null || !Navigator.canPop(context)) return;

    setFetching(true);
    final homeController = Provider.of<HomeProvider>(context, listen: false);

    Future<void> processGroupUsers(List<UserListModel> groupUsers) async {
      if (context == null || !Navigator.canPop(context)) return;

      print(groupUsers);
      setFetching(false);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return UserSelectionGroupDialog(
            userList: groupUsers,
            selectedOptions: [],
            onSelectionChanged: (List<String> selectedOptions) {
              addUsersToGroupRequest(
                  context, homeController.selectedBusiness, selectedOptions);
            },
          );
        },
      );
    }

    if (homeController.userlistModel == null) {
      await homeController.getUsersList().then((_) {
        processGroupUsers(
          removeUsersByIds(
            homeController.userlistModel ?? [],
            _groupModel?.usersIds ?? [],
          ),
        );
      });
    } else {
      processGroupUsers(
        removeUsersByIds(
          homeController.userlistModel ?? [],
          _groupModel?.usersIds ?? [],
        ),
      );
    }
  }

}
