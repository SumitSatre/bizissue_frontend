import 'dart:convert';

import 'package:bizissue/Issue/models/issue_model.dart';
import 'package:bizissue/api%20repository/product_repository.dart';
import 'package:bizissue/business_home_page/models/business_model.dart';
import 'package:bizissue/business_home_page/models/user_profile_model.model.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:bizissue/utils/services/shared_preferences_service.dart';
import 'package:bizissue/utils/utils.dart';
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

  List<IssueModel>? myIssues;
  List<IssueModel>? myTeamIssues;

  List<GroupIssue>? _myIssuesGroup;
  List<GroupIssue>? get myIssuesGroup => _myIssuesGroup;

  List<GroupIssue>? _myTeamIssuesGroup;
  List<GroupIssue>? get myTeamIssuesGroup => _myTeamIssuesGroup;

  late PageController pageController = PageController(initialPage: 0);

  String selectedBusiness = "";

  String selectedBCDFilter = "All";

  bool isSwitched = true;

  UserProfile? userProfile ;

  void init(String id) async {
    pageController = PageController();
    await sendUserGetRequest(id);
  }

  void clear() {
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
      myIssues = _businessModel?.myIssues ?? [];
      myTeamIssues = _businessModel?.myTeamIssues ?? [];
      _myIssuesGroup = groupAndSortIssues(_businessModel?.myIssues ?? []);
      _myTeamIssuesGroup =
          groupAndSortIssues(_businessModel?.myTeamIssues ?? []);
      print("Done");
      notifyListeners();
    } else {
      _isError = true;
      notifyListeners();
    }
  }

  void reGroupIssues(
      List<IssueModel>? myIssuess, List<IssueModel>? myTeamIssuess) {
    _myIssuesGroup = groupAndSortIssues(myIssuess ?? []);
    _myTeamIssuesGroup = groupAndSortIssues(myTeamIssuess ?? []);
    notifyListeners();
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

  void setBusinessModelNull() {
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

  Future<void> sendUserProfileGetRequest(String businessId , String userId) async {
    print("This is id : $businessId");
    String accessToken = await SharedPreferenceService().getAccessToken();
    ApiHttpResponse response =
    await callUserGetMethod("business/user/${businessId}/${userId}", accessToken);
    final data = jsonDecode(response.responceString!);
    debugPrint(data.toString());
    if (response.responseCode == 200) {
      print("This is data ${data["data"]}");
      userProfile = UserProfile.fromJson(data["data"]);

      print("This is userProfile data : ${userProfile.toString()}");
      print("Done");
    } else {
    }
    notifyListeners();
  }

  void setUserProfileNull(){
    userProfile = null;
  }

}
