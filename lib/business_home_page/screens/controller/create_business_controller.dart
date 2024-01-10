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

  bool _isError = false;
  bool get isError => _isError;


  void createBusiness(BuildContext context , String id) async {

    if(!areAllFieldsFilled()){
      showSnackBar(context, "Fill complete details!!", invalidColor);
      return;
    }
    String accessToken = await SharedPreferenceService().getAccessToken();

    print(jsonEncode(_createBusinessModel!.toJson()));

    ApiHttpResponse response = await callUserPostMethod(
        _createBusinessModel!.toJson(), 'business/create', accessToken);

    final data = jsonDecode(response.responceString!);

    if (response.responseCode == 200) {
      showSnackBar(context, "Business created Successfully!!", successColor);
      _createBusinessModel = null;
      notifyListeners();
    }
    debugPrint(response.responceString);
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

}