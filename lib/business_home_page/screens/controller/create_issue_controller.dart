import 'dart:convert';

import 'package:bizissue/api%20repository/api_http_response.dart';
import 'package:bizissue/api%20repository/product_repository.dart';
import 'package:bizissue/business_home_page/models/create_issue_model.dart';
import 'package:bizissue/business_home_page/models/user_list_model.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/services/shared_preferences_service.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:flutter/cupertino.dart';

class CreateIssueProvider extends ChangeNotifier {

  CreateIssueModel? _createIssueModel;
  CreateIssueModel? get createIssueModel => _createIssueModel;

  bool _isError = false;
  bool get isError => _isError;

  String? nameOfAssignToUser = null;

  Future<void> performTask() async {
    // Simulating a time-consuming task
    await Future.delayed(Duration(seconds: 2));
  }

  void clear(){
    _createIssueModel = null ;
    notifyListeners();
  }


  void postIssue(BuildContext context , String id) async {

    if(!areAllFieldsFilled()){
      showSnackBar(context, "Fill complete details!!", invalidColor);
      return;
    }
    String accessToken = await SharedPreferenceService().getAccessToken();

    print(jsonEncode(createIssueModel!.toJson()));

    ApiHttpResponse response = await callUserPostMethod(
        createIssueModel!.toJson(), 'issue/create/${id}', accessToken);

    final data = jsonDecode(response.responceString!);

    if (response.responseCode == 200) {
      showSnackBar(context, "Issue created Successfully!!", successColor);
      _createIssueModel = null;
      notifyListeners();
    }
    debugPrint(response.responceString);
  }

  bool areAllFieldsFilled() {
    // Check if all required fields are filled and not empty
    return _createIssueModel != null &&
        _createIssueModel!.assignedToId != null &&
        _createIssueModel!.assignedToId!.isNotEmpty &&
        _createIssueModel!.title != null &&
        _createIssueModel!.title!.isNotEmpty &&
        _createIssueModel!.deliveryDate != null &&
        _createIssueModel!.deliveryDate!.isNotEmpty &&
        _createIssueModel!.nextFollowUpDate != null &&
        _createIssueModel!.nextFollowUpDate!.isNotEmpty;
  }


  void updateAssignTo(UserListModel? userListItem) {
    if(userListItem != null){
      if (_createIssueModel != null ) {
        _createIssueModel = _createIssueModel!.copyWith(
          assignedToId: userListItem.userId,
        );
        // print("${userListItem.toJson()}");
      } else {
        _createIssueModel = CreateIssueModel(assignedToId: userListItem!.userId);
      }
    }

    notifyListeners();
  }


  void updateIssueTitle(String? title) {
    if (_createIssueModel != null) {
      _createIssueModel = _createIssueModel!.copyWith(
        title: title,
      );
    } else {
      _createIssueModel = CreateIssueModel(title: title);
    }

    print("Title : ${_createIssueModel!.title}");

    notifyListeners();
  }

  void updateIssueDetails(String? details) {
    if (_createIssueModel != null) {
      _createIssueModel = _createIssueModel!.copyWith(
        details: details,
      );
    } else {
      _createIssueModel = CreateIssueModel(details: details);
    }

    notifyListeners();
  }

  void updateDeliveryDateOfIssue(BuildContext context, String? deliveryDate) {
    if (deliveryDate != null && isValidDateFormat(deliveryDate)) {
      if (_createIssueModel != null) {
        _createIssueModel = _createIssueModel!.copyWith(
          deliveryDate: deliveryDate,
        );
      } else {
        _createIssueModel = CreateIssueModel(deliveryDate: deliveryDate);
      }
      print("Title : ${_createIssueModel!.deliveryDate}");
      notifyListeners();
    }
  }

  void updateNextFollowUpDateOfIssue(BuildContext context, String? nextFollowUpDate) {
    if (nextFollowUpDate != null && isValidDateFormat(nextFollowUpDate)) {
      if (_createIssueModel != null) {
        _createIssueModel = _createIssueModel!.copyWith(
          nextFollowUpDate: nextFollowUpDate,
        );
      } else {
        _createIssueModel = CreateIssueModel(nextFollowUpDate: nextFollowUpDate);
      }

      notifyListeners();
    }
  }
}