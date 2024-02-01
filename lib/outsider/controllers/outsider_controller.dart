
import 'dart:convert';

import 'package:bizissue/Issue/models/issue_model.dart';
import 'package:bizissue/api%20repository/product_repository.dart';
import 'package:bizissue/business_home_page/models/business_model.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/outsider/models/outsider_model.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:bizissue/utils/services/shared_preferences_service.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../api repository/api_http_response.dart';

class OutsiderProvider extends ChangeNotifier {

  bool _isError = false;
  bool get isError => _isError;

  OutsiderInfo? outsiderInfo;

  List<GroupIssue>? myIssuesGroup;

  Future<void> sendUserGetRequest(String id) async {
    print("This is id : $id");
    String accessToken = await SharedPreferenceService().getAccessToken();
    ApiHttpResponse response =
    await callUserGetMethod("business/get/outsider/${id}", accessToken);
    final data = jsonDecode(response.responceString!);
    debugPrint(data.toString());
    if (response.responseCode == 200) {
      // print("This is data ${data["data"]}");
      outsiderInfo = OutsiderInfo.fromJson(data["data"]);
      myIssuesGroup = groupAndSortIssues(outsiderInfo?.issues ?? []);
      print("Done");
      notifyListeners();
    } else {
      _isError = true;
      notifyListeners();
    }
  }

}