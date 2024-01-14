
import 'dart:convert';

import 'package:bizissue/api%20repository/product_repository.dart';
import 'package:bizissue/business_home_page/models/business_model.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:bizissue/utils/services/shared_preferences_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../api repository/api_http_response.dart';

class BusinessController extends ChangeNotifier {
  int _page = 0;
  int get page => _page;

  bool _isError = false;
  bool get isError => _isError;

  BusinessModel? _businessModel;
  BusinessModel? get businessModel => _businessModel;

  late PageController pageController = PageController(initialPage: 0);

  String selectedBusiness = "";

  String selectedBCDFilter = "All";

  bool isSwitched = true;

  void init(String id) async {
    pageController = PageController();
    await sendUserGetRequest(id);
  }

  void clear(){
    _businessModel = null;
    notifyListeners();
  }

  Future<void> sendUserGetRequest(String id) async {
    print("This is id : $id");
    String accessToken = await SharedPreferenceService().getAccessToken();
    ApiHttpResponse response =
    await callUserGetMethod("business/get/${id}", accessToken);
    final data = jsonDecode(response.responceString!);
    debugPrint(data.toString());
    if (response.responseCode == 200) {
      // print("This is data ${data["data"]}");
      _businessModel = BusinessModel.fromJson(data["data"]);
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

  void setBusinessModelNull(){
    _businessModel = null;
    _page = 0;
    notifyListeners();
  }

  Future<void> onRefresh(BuildContext context) async {
    setBusinessModelNull();
    GoRouter.of(context).goNamed(MyAppRouteConstants.businessRouteName);
    notifyListeners();
  }

  Future<void> onRestart(BuildContext context) async {
    setBusinessModelNull();
    Provider.of<HomeProvider>(context).init(context);
    GoRouter.of(context).goNamed(MyAppRouteConstants.homeRouteName);
    notifyListeners();
  }

}