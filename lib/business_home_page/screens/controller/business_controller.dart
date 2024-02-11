import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bizissue/Issue/models/issue_model.dart';
import 'package:bizissue/api%20repository/product_repository.dart';
import 'package:bizissue/business_home_page/models/business_model.dart';
import 'package:bizissue/business_home_page/models/user_profile_model.model.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/routes/app_route_constants.dart';
import 'package:bizissue/utils/services/shared_preferences_service.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../api repository/api_http_response.dart';
import '../../../utils/remote_routes.dart';

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

  void sortAccordingToDeliveryDate(){
    _myIssuesGroup = groupAndSortIssuesDeliveryDate(_businessModel?.myIssues ?? []);
    _myTeamIssuesGroup =
        groupAndSortIssuesDeliveryDate(_businessModel?.myTeamIssues ?? []);
  }

  void sortAccordingToNextFollowUpDate(){
    _myIssuesGroup = groupAndSortIssues(_businessModel?.myIssues ?? []);
    _myTeamIssuesGroup =
        groupAndSortIssues(_businessModel?.myTeamIssues ?? []);
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

  void rateUserRequest(BuildContext context, String businessId , String userId , String message , double rating , bool isAnonymous) async {

    try {
      // Validate business code
      if (businessId == null || businessId.isEmpty) {
        showSnackBar(context, "Invalid business code!!", invalidColor);
        return;
      }

      if (userId == null || userId.isEmpty) {
        showSnackBar(context, "Invalid user code!!", invalidColor);
        return;
      }

      if (message == null || message.isEmpty) {
        showSnackBar(context, "Please give message!!", invalidColor);
        return;
      }

      String accessToken = await SharedPreferenceService().getAccessToken();

      ApiHttpResponse response = await callUserPatchMethod(
          {
            "message" : message,
            "rating" : rating
          },
          'business/rate/user/${businessId}/${userId}?isAnonymous=${isAnonymous}',
          accessToken);

      if (response.responseCode == 200) {
        final businessController =
        Provider.of<BusinessController>(context, listen: false);

        businessController.setBusinessModelNull();

        GoRouter.of(context).pop();
        showSnackBar(context, "User rated successfully!!", successColor);
        notifyListeners();
      } else {
        final data = jsonDecode(response.responceString ?? "");
        showSnackBar(
            context,
            "Failed to send user rate request to business: ${data['message']}",
            invalidColor);
      }

      debugPrint(response.responceString);
    } catch (e) {
      showSnackBar(context, "An unexpected error occurred", invalidColor);
      print("Error: $e");
    }
    notifyListeners();
  }

  final String csvContent = '''
Title,Assigned To number,Delivery Date,Next Follow Up Date
,,,,
''';

  Future<void> downloadCsvTemplate(context) async {
    print("Hiii");
    final savePath = "/storage/emulated/0/Download/template.csv";
    print("This is save path : ${savePath}");
    if (savePath.isNotEmpty) { // Ensure savePath is not empty
      final file = File(savePath);
      await file.writeAsString(csvContent);
      showSnackBar(
          context,
          "Saved successfully in your downloads folder!!",
          successColor);
    } else {
      // Handle the case when appDir is null or savePath is empty
      showSnackBar(
          context,
          "Failed to save template file!!",
          invalidColor);
    }
  }

  Future<void> pickAndUploadCsvFile(BuildContext context, String businessId) async {

    String authToken = await SharedPreferenceService().getAccessToken();

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);

      try {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('https://bizissue-backend.onrender.com/api/v1/issues/upload/csv/$businessId'),
        );

        // Add bearer token to headers
        request.headers['Authorization'] = 'Bearer $authToken';

        request.files.add(await http.MultipartFile.fromPath('csvFile', file.path));

        var response = await request.send();

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('CSV file uploaded successfully!'),
          ));
        } else {
          String responseString = await response.stream.bytesToString();
          var responseData = json.decode(responseString);

          String errorMessage = responseData['message'] ?? 'Failed to upload CSV file';

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(errorMessage),
          ));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: $e'),
        ));
      }
    } else {
      // User canceled the picker
    }
  }

}
