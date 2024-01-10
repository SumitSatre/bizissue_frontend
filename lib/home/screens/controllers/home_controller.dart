import 'dart:convert';

import 'package:bizissue/api%20repository/api_http_response.dart';
import 'package:bizissue/api%20repository/product_repository.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:bizissue/utils/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/user_model.dart';
import '../../../business_home_page/screens/business_home_page.dart';

class HomeProvider extends ChangeNotifier {
  int _page = 0;
  int get page => _page;

  bool _isError = false;
  bool get isError => _isError;

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  late PageController pageController;

  String selectedBusiness = "";

  void init() async {
    pageController = PageController();
    await sendUserGetRequest();
  }

  Future<void> sendUserGetRequest() async {
    String accessToken = await SharedPreferenceService().getAccessToken();
    ApiHttpResponse response =
    await callUserGetMethod("user", accessToken);
    final data = jsonDecode(response.responceString!);
    debugPrint(data.toString());
    if (response.responseCode == 200) {
      print("This is data ${data["data"]}");
      _userModel = UserModel.fromJson(data["data"]);

      if(_userModel!.businesses.length > 0){
        selectedBusiness = _userModel!.businesses[0].businessId;
      }
      notifyListeners();
    } else {
      _isError = true;
      notifyListeners();
    }
  }


  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    _page = page;
    notifyListeners();
  }

  void updateisError() {
    _isError = false;
    notifyListeners();
  }

  void updateSelected(BuildContext context , String businessId){
    selectedBusiness = businessId;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BusinessHomePage(id: selectedBusiness),
      ),
    );

    notifyListeners();
  }

  void setNewBusiness(BuildContext context , String businessId){
    selectedBusiness = businessId;
    GoRouter.of(context).goNamed(MyAppRouteConstants.businessRouteName);
    notifyListeners();
  }

}
