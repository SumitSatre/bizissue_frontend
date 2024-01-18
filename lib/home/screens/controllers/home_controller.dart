import 'dart:convert';

import 'package:bizissue/api%20repository/api_http_response.dart';
import 'package:bizissue/api%20repository/product_repository.dart';
import 'package:bizissue/business_home_page/models/user_list_model.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:bizissue/utils/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../../business_home_page/screens/business home/business_home_page.dart';

class HomeProvider extends ChangeNotifier {
  int _page = 0;
  int get page => _page;

  bool _isError = false;
  bool get isError => _isError;

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  late PageController pageController;

  String selectedBusiness = "";

  void init(BuildContext context) async {
    pageController = PageController();
    await sendUserGetRequest(context);
  }

  Future<void> sendUserGetRequest(BuildContext context) async {
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
    }
    else if(response.responseCode == 401){
      GoRouter.of(context).goNamed(MyAppRouteConstants.loginRouteName); // Token error solved
      print("TOken error happened");
      return;
      notifyListeners();
    }
    else {
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

  void onRestart(context){
    Provider.of<HomeProvider>(context, listen: false).init(context);
    notifyListeners();
  }

  List<UserListModel>? _userlistModel;
  List<UserListModel>? get userlistModel => _userlistModel;

  List<UserListModel>? _userlistModelWihoutMySelf;
  List<UserListModel>? get userlistModelWihoutMySelf => _userlistModelWihoutMySelf;

  Future<List<UserListModel>> getUsersList() async {
    if (_userlistModel == null && _userModel != null ) {
      print("This is business id : $selectedBusiness");
      String accessToken = await SharedPreferenceService().getAccessToken();
      ApiHttpResponse response =
      await callUserGetMethod("issue/get/business/users/${this.selectedBusiness}", accessToken);
      final data = jsonDecode(response.responceString!);
      debugPrint(data.toString());
      if (response.responseCode == 200) {
        print("This is data of users lists : ${data["data"]["users"]}");

        _userlistModel = (data["data"]["users"] as List)
            .map((item) => UserListModel.fromJson(item))
            .toList();

        _userlistModelWihoutMySelf = List.from(_userlistModel ?? []);
        _userlistModelWihoutMySelf!.removeWhere((user) => user.userId == _userModel!.id);

        notifyListeners();
        return _userlistModel!;
      } else {
        // Handle the error case accordingly
        return []; // Or throw an exception, or handle it as needed
      }
    }

    // If _userlistModel is not null, return the cached list
    return _userlistModel!;
  }

  void setUserListNull(){
    _userlistModel= null;
    _userlistModelWihoutMySelf = null;
  }

}
