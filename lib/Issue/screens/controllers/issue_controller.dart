import 'dart:convert';

import 'package:bizissue/Issue/models/issue_model.dart';
import 'package:bizissue/Issue/models/message_model.dart';
import 'package:bizissue/api%20repository/api_http_response.dart';
import 'package:bizissue/api%20repository/product_repository.dart';
import 'package:bizissue/business_home_page/screens/controller/business_controller.dart';
import 'package:bizissue/home/screens/controllers/home_controller.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/services/shared_preferences_service.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class IssueProvider extends ChangeNotifier {
  IssueModel? _issueModel;
  IssueModel? get issueModel => _issueModel;

  List<MessageModel>? messages;

  bool _isError = false;
  bool get isError => _isError;

  bool _isFetching = false;
  bool get isFetching => _isFetching;

  Future<void> sendIssueGetRequest(String businessId, String issueId) async {
    print("This is business id : $businessId");
    String accessToken = await SharedPreferenceService().getAccessToken();
    ApiHttpResponse response = await callUserGetMethod(
        "issue/get/${businessId}?issueId=${issueId}", accessToken);
    final data = jsonDecode(response.responceString!);
    debugPrint(data.toString());
    if (response.responseCode == 200) {
      // print("This is data ${data["data"]}");
      _issueModel = IssueModel.fromJson(data["data"]);

      notifyListeners();
    } else {
      _isError = true;
      notifyListeners();
    }
  }

  Future<void> sendIssueChatsGetRequest(
      String businessId, String issueId) async {
    print("This is business id : $businessId");
    String accessToken = await SharedPreferenceService().getAccessToken();
    ApiHttpResponse response = await callUserGetMethod(
        "issue/get/chats/${businessId}?issueId=${issueId}", accessToken);
    final data = jsonDecode(response.responceString!);
    debugPrint(data.toString());
    if (response.responseCode == 200) {
      // print("This is data ${data["data"]}");
      messages = (data["data"]["chats"] as List)
          .map((item) => MessageModel.fromJson(item))
          .toList();

      print("These are chats : ${messages.toString()}");
      notifyListeners();
    } else {
      _isError = true;
      notifyListeners();
    }
  }

  void clearData() {
    _issueModel = null;
    _isError = false;
    _isFetching = false;
    notifyListeners();
  }

  void setFetching(bool val) {
    _isFetching = val;
    notifyListeners();
  }

  void bockIssueRequest(BuildContext context, String businessId) async {
    try {
      // Validate business code
      if (businessId == null || businessId.isEmpty) {
        showSnackBar(context, "Invalid business code!!", invalidColor);
        return;
      }

      if (issueModel == null || issueModel!.issueId == null) {
        showSnackBar(context, "Something got wrong!!", invalidColor);
        return;
      }

      String accessToken = await SharedPreferenceService().getAccessToken();

      ApiHttpResponse response = await callUserPatchMethod({},
          'issue/block/${businessId}?issueId=${issueModel!.issueId}',
          accessToken);

      if (response.responseCode == 200) {
        _issueModel = _issueModel!
            .copyWith(blocked: _issueModel!.blocked.copyWith(isBlocked: true));

        showSnackBar(context, "Issue blocked successfully!!", successColor);
        notifyListeners();
      } else {
        final data = jsonDecode(response.responceString ?? "");
        // Handle other status codes if needed
        showSnackBar(
            context,
            "Failed to send block request to business: ${data['message']}",
            invalidColor);
      }

      debugPrint(response.responceString);
    } catch (e) {
      // Handle unexpected errors
      showSnackBar(context, "An unexpected error occurred", invalidColor);
      print("Error: $e");
    }
    setFetching(false);
  }

  void unbockIssueRequest(BuildContext context, String businessId) async {
    try {
      // Validate business code
      if (businessId == null || businessId.isEmpty) {
        showSnackBar(context, "Invalid business code!!", invalidColor);
        return;
      }

      if (issueModel == null || issueModel!.issueId == null) {
        showSnackBar(context, "Something got wrong!!", invalidColor);
        return;
      }

      String accessToken = await SharedPreferenceService().getAccessToken();

      ApiHttpResponse response = await callUserPatchMethod({},
          'issue/unblock/${businessId}?issueId=${issueModel!.issueId}',
          accessToken);

      if (response.responseCode == 200) {
        _issueModel = _issueModel!
            .copyWith(blocked: _issueModel!.blocked.copyWith(isBlocked: false));

        showSnackBar(context, "Issue unblocked successfully!!", successColor);
        notifyListeners();
      } else {
        final data = jsonDecode(response.responceString ?? "");
        // Handle other status codes if needed
        showSnackBar(
            context,
            "Failed to send block request to business: ${data['message']}",
            invalidColor);
      }

      debugPrint(response.responceString);
    } catch (e) {
      // Handle unexpected errors
      showSnackBar(context, "An unexpected error occurred", invalidColor);
      print("Error: $e");
    }
    setFetching(false);
  }

  void markCriticalIssueRequest(BuildContext context, String businessId) async {
    try {
      // Validate business code
      if (businessId == null || businessId.isEmpty) {
        showSnackBar(context, "Invalid business code!!", invalidColor);
        return;
      }

      if (issueModel == null || issueModel!.issueId == null) {
        showSnackBar(context, "Something got wrong!!", invalidColor);
        return;
      }

      String accessToken = await SharedPreferenceService().getAccessToken();

      ApiHttpResponse response = await callUserPatchMethod({},
          'issue/markcritical/${businessId}?issueId=${issueModel!.issueId}',
          accessToken);

      if (response.responseCode == 200) {
        _issueModel = _issueModel!.copyWith(
            critical: _issueModel!.critical.copyWith(isCritical: true));

        showSnackBar(context, "Issue blocked successfully!!", successColor);
        notifyListeners();
      } else {
        final data = jsonDecode(response.responceString ?? "");
        // Handle other status codes if needed
        showSnackBar(
            context,
            "Failed to send block request to business: ${data['message']}",
            invalidColor);
      }

      debugPrint(response.responceString);
    } catch (e) {
      // Handle unexpected errors
      showSnackBar(context, "An unexpected error occurred", invalidColor);
      print("Error: $e");
    }
    setFetching(false);
  }

  void unmarkCriticalIssueRequest(
      BuildContext context, String businessId) async {
    try {
      // Validate business code
      if (businessId == null || businessId.isEmpty) {
        showSnackBar(context, "Invalid business code!!", invalidColor);
        return;
      }

      if (issueModel == null || issueModel!.issueId == null) {
        showSnackBar(context, "Something got wrong!!", invalidColor);
        return;
      }

      String accessToken = await SharedPreferenceService().getAccessToken();

      ApiHttpResponse response = await callUserPatchMethod({},
          'issue/unmarkcritical/${businessId}?issueId=${issueModel!.issueId}',
          accessToken);

      if (response.responseCode == 200) {
        _issueModel = _issueModel!.copyWith(
            critical: _issueModel!.critical.copyWith(isCritical: false));

        showSnackBar(context, "Issue marked as critical!!", successColor);
        notifyListeners();
      } else {
        final data = jsonDecode(response.responceString ?? "");
        // Handle other status codes if needed
        showSnackBar(
            context,
            "Failed to send block request to business: ${data['message']}",
            invalidColor);
      }

      debugPrint(response.responceString);
    } catch (e) {
      // Handle unexpected errors
      showSnackBar(context, "An unexpected error occurred", invalidColor);
      print("Error: $e");
    }
    setFetching(false);
  }

  void updateDeliveryDateRequest(
      BuildContext context, String businessId, String deliveryDate) async {
    try {
      // Validate business code
      if (businessId == null || businessId.isEmpty) {
        showSnackBar(context, "Invalid business code!!", invalidColor);
        return;
      }

      if (issueModel == null || issueModel!.issueId == null) {
        showSnackBar(context, "Something got wrong!!", invalidColor);
        return;
      }

      String accessToken = await SharedPreferenceService().getAccessToken();

      ApiHttpResponse response = await callUserPatchMethod({},
          'issue/update/deliverydate/${businessId}?issueId=${issueModel!.issueId}&deliveryDate=${deliveryDate}',
          accessToken);

      if (response.responseCode == 200) {
        int delayed = _issueModel?.delayed ?? 0;
        _issueModel = _issueModel!
            .copyWith(deliveryDate: deliveryDate, delayed: delayed + 1);

        showSnackBar(
            context, "Delivery date updated succesfully!!", successColor);
        notifyListeners();
      } else {
        final data = jsonDecode(response.responceString ?? "");
        // Handle other status codes if needed
        showSnackBar(context,
            "Failed to update delivery date: ${data['message']}", invalidColor);
      }

      debugPrint(response.responceString);
    } catch (e) {
      // Handle unexpected errors
      showSnackBar(context, "An unexpected error occurred", invalidColor);
      print("Error: $e");
    }
    setFetching(false);
  }

  void updateNextFollowUpDateRequest(
      BuildContext context, String businessId, String nextFollowUpDate) async {
    try {
      // Validate business code
      if (businessId == null || businessId.isEmpty) {
        showSnackBar(context, "Invalid business code!!", invalidColor);
        return;
      }

      if (issueModel == null || issueModel!.issueId == null) {
        showSnackBar(context, "Something got wrong!!", invalidColor);
        return;
      }

      String accessToken = await SharedPreferenceService().getAccessToken();

      ApiHttpResponse response = await callUserPatchMethod({},
          'issue/update/nextfollowupdate/${businessId}?issueId=${issueModel!.issueId}&nextFollowUpDate=${nextFollowUpDate}',
          accessToken);

      if (response.responseCode == 200) {
        _issueModel = _issueModel!.copyWith(nextFollowUpDate: nextFollowUpDate);

        showSnackBar(
            context, "Next follow up date updated succesfully!!", successColor);
        notifyListeners();
      } else {
        final data = jsonDecode(response.responceString ?? "");
        // Handle other status codes if needed
        showSnackBar(
            context,
            "Failed to update Next follow up date: ${data['message']}",
            invalidColor);
      }

      debugPrint(response.responceString);
    } catch (e) {
      // Handle unexpected errors
      showSnackBar(context, "An unexpected error occurred", invalidColor);
      print("Error: $e");
    }
    setFetching(false);
  }

  Future<String> uploadDocument(File file, String filename) async {
    try {
      if (file == null) {
        throw Exception("No document provided");
      }

      Reference ref = FirebaseStorage.instance.ref().child("files/${filename}");

      UploadTask task = ref.putFile(file);

      TaskSnapshot snapshot = await task;

      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      return "failure";
    }
  }

  void sentInviteToOutsiderRequest(
      BuildContext context, String countryCode, String number) async {
    try {
      final homeController = Provider.of<HomeProvider>(context, listen: false);

      String businessId = homeController.selectedBusiness;
      String businessName =
          Provider.of<BusinessController>(context, listen: false)
              .businessModel!
              .business
              .name;

      if (countryCode == "" || number.length != 10) {
        // showSnackBar(context, "Contact number is not valid!!", invalidColor);
        return;
      }

      if (businessId == null || businessId.isEmpty) {
        //  showSnackBar(context, "Invalid business code!!", invalidColor);
        return;
      }

      if (issueModel == null || issueModel!.issueId == null) {
        //  showSnackBar(context, "Something got wrong!!", invalidColor);
        return;
      }

      String accessToken = await SharedPreferenceService().getAccessToken();

      var json = {
        "businessName": businessName,
        "issueId": issueModel!.issueId,
        "contactNumber": {"countryCode": countryCode, "number": number}
      };
      print("This is data ${json.toString()}");

      ApiHttpResponse response = await callUserPutMethod({
        "businessName": businessName,
        "issueId": issueModel!.issueId,
        "contactNumber": {"countryCode": countryCode, "number": number}
      }, 'issue/invite/user/${businessId}', accessToken);

      print("This is response $response");
      if (response.responseCode == 200) {
        //  showSnackBar(context, "Invite sent successfully!!", successColor);
        notifyListeners();
      } else {
        final data = jsonDecode(response.responceString ?? "");
        // Handle other status codes if needed
        //  showSnackBar(
        //      context,
        //      "Failed to send invite request to user: ${data['message']}",
        //      invalidColor);
      }

      debugPrint(response.responceString);
    } catch (e) {
      // Handle unexpected errors
      showSnackBar(context, "An unexpected error occurred", invalidColor);
      print("Error: $e");
    }
    setFetching(false);
  }

  void closeIssueRequest(BuildContext context, String businessId) async {
    try {
      // Validate business code
      if (businessId == null || businessId.isEmpty) {
        //      showSnackBar(context, "Invalid business code!!", invalidColor);
        return;
      }

      if (issueModel == null || issueModel!.issueId == null) {
        //      showSnackBar(context, "Something got wrong!!", invalidColor);
        return;
      }

      String accessToken = await SharedPreferenceService().getAccessToken();

      ApiHttpResponse response = await callUserPatchMethod({},
          'issue/close/${businessId}?issueId=${issueModel!.issueId}',
          accessToken);

      if (response.responseCode == 200) {
        final businessController =
            Provider.of<BusinessController>(context, listen: false);

        businessController.setBusinessModelNull();

        GoRouter.of(context).pop();
        //    showSnackBar(context, "Issue blocked successfully!!", successColor);
        notifyListeners();
      } else {
        final data = jsonDecode(response.responceString ?? "");
        // Handle other status codes if needed
        //    showSnackBar(
        //        context,
        //        "Failed to send block request to business: ${data['message']}",
        //        invalidColor);
      }

      debugPrint(response.responceString);
    } catch (e) {
      // Handle unexpected errors
      // showSnackBar(context, "An unexpected error occurred", invalidColor);
      print("Error: $e");
    }
    setFetching(false);
  }
}

/*

      // Add the file to the request
      var stream = http.ByteStream(file.openRead());
      var length = await file.length();
      var multipartFile = http.MultipartFile(
        'document',
        stream,
        length,
        filename: path.basename(file.path),
      );

      request.files.add(multipartFile);

      // Send the request
      var response = await request.send();

      // Read response stream and convert to string
      var responseData = await response.stream.bytesToString();

      // Parse the JSON response data
      var jsonResponse = json.decode(responseData);

      // Print the response data
      print("Response Data: $jsonResponse");

      // Check the status code of the response
      if (response.statusCode == 200) {
        // Handle success
        print('Document uploaded successfully.');

        // Extract documentUrl from jsonResponse
        String docUrl = jsonResponse['documentUrl'];

        return docUrl;
      } else {
        return "failure";
        // Handle failure
        throw Exception('Failed to upload document. Status code: ${response.statusCode}');

      }
    } catch (error) {
      // Handle errors
      return "failure";
      print('Error uploading document: $error');
      throw error;
    }
  }*/
