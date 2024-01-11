import 'dart:convert';

import 'package:bizissue/api%20repository/api_http_response.dart';
import 'package:bizissue/api%20repository/product_repository.dart';
import 'package:bizissue/business_home_page/models/create_business_model.dart';
import 'package:bizissue/business_home_page/models/create_issue_model.dart';
import 'package:bizissue/business_home_page/models/user_list_model.dart';
import 'package:bizissue/utils/colors.dart';
import 'package:bizissue/utils/services/shared_preferences_service.dart';
import 'package:bizissue/utils/utils.dart';
import 'package:flutter/cupertino.dart';

class CreateBusinessProvider extends ChangeNotifier {

  CreateBusinessModel? _createBusinessModel;
  CreateBusinessModel? get createBusinessModel => _createBusinessModel;

  final nameController = TextEditingController();
  final industryTypeController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();

  bool _isError = false;
  bool get isError => _isError;


  void createBusiness(BuildContext context) async {
    try {
      if (!areAllFieldsFilled()) {
        showSnackBar(context, "Fill complete details!!", invalidColor);
        return;
      }

      String accessToken = await SharedPreferenceService().getAccessToken();

      print(jsonEncode(_createBusinessModel!.toJson()));

      ApiHttpResponse response = await callUserPostMethod(
          _createBusinessModel!.toJson(), 'business/create', accessToken);

      if (response.responseCode == 200) {
        showSnackBar(context, "Business created Successfully!!", successColor);

        notifyListeners();
        dispose();
      } else {
        final data = jsonDecode(response.responceString ?? "");
        // Handle other status codes if needed
        showSnackBar(context, "Failed to create business: ${data['message']}", invalidColor);
      }

      debugPrint(response.responceString);
    } catch (e) {
      // Handle unexpected errors
      showSnackBar(context, "An unexpected error occurred", invalidColor);
      print("Error: $e");
    }
  }

  void joinBusinessRequest(BuildContext context, String businessCode) async {
    try {
      // Validate business code
      if (businessCode == null || businessCode.isEmpty || businessCode.length != 6) {
        showSnackBar(context, "Invalid business code!!", invalidColor);
        return;
      }

      String accessToken = await SharedPreferenceService().getAccessToken();

      ApiHttpResponse response = await callUserPatchMethod(
          {}, 'business/send/request/$businessCode', accessToken);

      if (response.responseCode == 200) {
        showSnackBar(context, "Request sent Successfully!!", successColor);
        notifyListeners();
      } else {
        final data = jsonDecode(response.responceString ?? "");
        // Handle other status codes if needed
        showSnackBar(context, "Failed to send join request to business: ${data['message']}", invalidColor);
      }

      debugPrint(response.responceString);
    } catch (e) {
      // Handle unexpected errors
      showSnackBar(context, "An unexpected error occurred", invalidColor);
      print("Error: $e");
    }
  }

  bool areAllFieldsFilled() {
    return _createBusinessModel != null &&
        _createBusinessModel!.name != null &&
        _createBusinessModel!.name!.isNotEmpty;
  }

  void updateBusinessName(String? name) {
    if (_createBusinessModel != null) {
      _createBusinessModel = _createBusinessModel!.copyWith(
        name : name,
      );
    } else {
      _createBusinessModel = CreateBusinessModel(name: name);
    }
    notifyListeners();
  }

  void updateBusinessIndustryType(String? industryType) {
    if (_createBusinessModel != null) {
      _createBusinessModel = _createBusinessModel!.copyWith(
        industryType : industryType,
      );
    } else {
      _createBusinessModel = CreateBusinessModel(industryType: industryType);
    }
    notifyListeners();
  }

  void updateBusinessCity(String? city) {
    if (_createBusinessModel != null) {
      _createBusinessModel = _createBusinessModel!.copyWith(
        city : city,
      );
    } else {
      _createBusinessModel = CreateBusinessModel(city: city);
    }
    notifyListeners();
  }

  void updateBusinessCountry(String? country) {
    if (_createBusinessModel != null) {
      _createBusinessModel = _createBusinessModel!.copyWith(
        country : country,
      );
    } else {
      _createBusinessModel = CreateBusinessModel(country: country);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.clear();
    industryTypeController.clear();
    cityController.clear();
    countryController.clear();
    super.dispose();
  }

}