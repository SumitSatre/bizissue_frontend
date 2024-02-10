import 'dart:convert';
import 'dart:io';
import 'package:bizissue/utils/remote_routes.dart';
import 'package:flutter/material.dart';
import 'api_http_response.dart';
import 'package:http/http.dart' as http;

String domain = AppRemoteRoutes.baseUrl;
Future<ApiHttpResponse> callPostMethod(
    Map<String, dynamic> authData, String apiUrl) async {
  try {
    String url = domain + apiUrl;
    debugPrint(url);
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'accept': ' */*'
    };

    http.Response response = await http.post(Uri.parse(url),
        body: json.encode(authData), headers: header);
    ApiHttpResponse apiResponse = ApiHttpResponse();

    apiResponse.responseCode = response.statusCode;
    apiResponse.responceString = response.body;

    print("This is ${apiResponse.responceString}");

    return apiResponse;
  } on SocketException catch (_) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.message = _.message;
    apiResponse.responceString =
        json.encode({"success": false, "message": _.message});
    return apiResponse;
  } catch (e) {
    debugPrint("catch error $e");
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.message = AppRemoteRoutes.someThingWentWrong;
    apiResponse.responceString = json.encode(
        {"success": false, "message": AppRemoteRoutes.someThingWentWrong});
    return apiResponse;
  }
}

Future<ApiHttpResponse> callUserPostMethod(
    Map authData, String apiUrl, String token) async {
  try {
    String url = domain + apiUrl;

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'accept': ' */*',
      'authorization': 'Bearer $token',
    };

    http.Response response = await http.post(Uri.parse(url),
        body: json.encode(authData), headers: header);
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = response.statusCode;
    apiResponse.responceString = response.body;

    return apiResponse;
  } on SocketException catch (_) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 503;
    apiResponse.responceString = json.encode({
      "success": false,
      "message": "Service temporarily unavailable due to internet connection issues",
    });
    return apiResponse;
  } on http.ClientException catch (e) {
    // Handle token-related issues
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responceString = json.encode(
        {"success": false, "message": "Token is Invalid"});
    return apiResponse;
  } catch (e) {
    debugPrint("catch error $e");
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responceString = json.encode(
        {"success": false, "message": AppRemoteRoutes.someThingWentWrong});
    return apiResponse;
  }
}

Future<ApiHttpResponse> callUserPutMethod(
    Map authData, String apiUrl, String token) async {
  try {
    String url = domain + apiUrl;

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'accept': ' */*',
      'authorization': 'Bearer $token',
    };

    http.Response response = await http.put(Uri.parse(url),
        body: json.encode(authData), headers: header);
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = response.statusCode;
    apiResponse.responceString = response.body;

    return apiResponse;
  } on SocketException catch (_) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 503;
    apiResponse.responceString = json.encode({
      "success": false,
      "message": "Service temporarily unavailable due to internet connection issues",
    });
    return apiResponse;
  } on http.ClientException catch (e) {
    // Handle token-related issues
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responceString = json.encode(
        {"success": false, "message": "Token is Invalid"});
    return apiResponse;
  } catch (e) {
    debugPrint("catch error $e");
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responceString = json.encode(
        {"success": false, "message": AppRemoteRoutes.someThingWentWrong});
    return apiResponse;
  }
}



Future<ApiHttpResponse> callGetMethod(String apiUrl) async {
  try {
    String url = domain + apiUrl;

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'accept': ' */*',
    };

    http.Response response = await http.get(Uri.parse(url), headers: header);
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = response.statusCode;
    apiResponse.responceString = response.body;
    return apiResponse;
  } on SocketException catch (_) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responceString = json.encode(
        {"success": false, "message": AppRemoteRoutes.internetConnectionMsg});
    return apiResponse;
  } catch (e) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responceString = json.encode(
        {"success": false, "message": AppRemoteRoutes.someThingWentWrong});
    return apiResponse;
  }
}

Future<ApiHttpResponse> callUserGetMethod(String apiUrl, String token) async {
  try {
    String url = domain + apiUrl;

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token',
      'accept': ' */*',
    };

    http.Response response = await http.get(Uri.parse(url), headers: header);
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = response.statusCode;
    apiResponse.responceString = response.body;
    return apiResponse;
  } on SocketException catch (_) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responceString = json.encode(
        {"success": false, "message": AppRemoteRoutes.internetConnectionMsg});
    return apiResponse;
  } catch (e) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responceString = json.encode(
        {"success": false, "message": AppRemoteRoutes.someThingWentWrong});
    return apiResponse;
  }
}

Future<ApiHttpResponse> callPutMethod(Map authData, String apiUrl) async {
  try {
    String url = domain + apiUrl;

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'accept': ' */*',
    };

    http.Response response = await http.put(Uri.parse(url),
        body: json.encode(authData), headers: header);
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = response.statusCode;
    apiResponse.responceString = response.body;

    return apiResponse;
  } on SocketException catch (_) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responceString = json.encode(
        {"success": false, "message": AppRemoteRoutes.internetConnectionMsg});
    return apiResponse;
  } catch (e) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responceString = json.encode(
        {"success": false, "message": AppRemoteRoutes.someThingWentWrong});
    return apiResponse;
  }
}

Future<ApiHttpResponse> callDeleteMethod(Map authData, String apiUrl) async {
  try {
    String url = domain + apiUrl;

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'accept': ' */*',
    };

    http.Response response = await http.delete(Uri.parse(url),
        body: json.encode(authData), headers: header);
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = response.statusCode;
    apiResponse.responceString = response.body;

    return apiResponse;
  } on SocketException catch (_) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responceString = json.encode(
        {"success": false, "message": AppRemoteRoutes.internetConnectionMsg});
    return apiResponse;
  } catch (e) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responceString = json.encode(
        {"success": false, "message": AppRemoteRoutes.someThingWentWrong});
    return apiResponse;
  }
}

Future<ApiHttpResponse> callUserDeleteMethod(
    Map authData, String apiUrl, String token) async {
  try {
    String url = domain + apiUrl;

    Map<String, String> header = {
      'Content-Type': 'application/json',
      'accept': ' */*',
      'authorization': 'Bearer $token',
    };

    http.Response response = await http.delete(Uri.parse(url),
        body: json.encode(authData), headers: header);
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = response.statusCode;
    apiResponse.responceString = response.body;

    return apiResponse;
  } on SocketException catch (_) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responceString = json.encode(
        {"success": false, "message": AppRemoteRoutes.internetConnectionMsg});
    return apiResponse;
  } catch (e) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responceString = json.encode(
        {"success": false, "message": AppRemoteRoutes.someThingWentWrong});
    return apiResponse;
  }
}

Future<ApiHttpResponse> callUserPatchMethod(
    Map authData, String apiUrl, String token) async {
  try {
    String url = domain + apiUrl;

    print("This is $url");
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'accept': ' */*',
      'authorization': 'Bearer $token',
    };

    http.Response response = await http.patch(Uri.parse(url),
        body: json.encode(authData), headers: header);
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = response.statusCode;
    apiResponse.responceString = response.body;
print("this is response ${response.body.toString()}");
    return apiResponse;
  } on SocketException catch (_) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responceString = json.encode(
        {"success": false, "message": AppRemoteRoutes.internetConnectionMsg});
    return apiResponse;
  } catch (e) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responceString = json.encode(
        {"success": false, "message": AppRemoteRoutes.someThingWentWrong});
    return apiResponse;
  }
}


Future<ApiHttpResponse> callGetDistrictAndPincodeFromPincodeMethod(int pincode) async {
  try {
    String url = "https://api.postalpincode.in/pincode/$pincode";

    Map<String, String> header = {
    };

    http.Response response = await http.get(Uri.parse(url), headers: header);
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = response.statusCode;
    apiResponse.responceString = response.body;
    return apiResponse;
  } on SocketException catch (_) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responceString = json.encode(
        {"success": false, "message": AppRemoteRoutes.internetConnectionMsg});
    return apiResponse;
  } catch (e) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responceString = json.encode(
        {"success": false, "message": AppRemoteRoutes.someThingWentWrong});
    return apiResponse;
  }
}