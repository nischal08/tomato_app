import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomato_app/api/api_call.dart';
import 'package:tomato_app/api/api_endpoints.dart';
import 'package:tomato_app/models/login_response.dart';
import 'package:tomato_app/models/user_response.dart';
import 'package:tomato_app/screens/home.dart';
import 'package:tomato_app/screens/login_screen.dart';
import 'package:tomato_app/screens/verification-screen.dart';
import 'package:tomato_app/widgets/reusable_widget.dart';

class Auth extends ChangeNotifier {
  bool showLoginSpinner = false;
  bool showRegisterSpinner = false;
  bool showVerifyCodeSpinner = false;
  UserResponse? userInfoResponse;

  Future<void> loginUser(context,
      {required String email, required String password}) async {
    showLoginSpinner = true;
    notifyListeners();
    late Response response;
    String url =
        "${ApiEndpoints.baseUrl}/api/${ApiEndpoints.version}/auth/login";
    Map jsonData = {
      "email": email,
      "password": password,
    };
    try {
      response = await ApiCall.postApi(jsonData: jsonData, url: url);

      if (json.decode(response.body)["success"] as bool == true) {
        LoginResponse successResponse = LoginResponse.fromJson(response.body);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("accessToken", successResponse.data.accessToken);
        preferences.setString(
            "refreshToken", successResponse.data.refreshToken);

        Map<String, dynamic> decodedToken =
            JwtDecoder.decode(successResponse.data.accessToken);
        preferences.setString("userId", decodedToken["_id"]);
        print("User Data !!!");
        print(preferences.getString("userId"));
        print(preferences.getString("accessToken"));
        print(preferences.getString("refreshToken"));
        print("User Data !!!");
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        ScaffoldMessenger.of(context)
            .showSnackBar(generalSnackBar(successResponse.message, context));
      } else {
        var errMessage = json.decode(response.body)["message"];
        generalAlertDialog(context, errMessage);
      }

      showLoginSpinner = false;

      notifyListeners();
    } catch (e) {
      generalAlertDialog(context, e.toString());
    }
  }

  Future<void> logoutUser(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("refreshToken");
    pref.remove("accessToken");
    pref.remove("userId");
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future<void> registerUser(
    context, {
    required String email,
    required String password,
    required String firstname,
    required String lastname,
  }) async {
    showRegisterSpinner = true;
    notifyListeners();
    late Response response;
    Map<String, String> _userCerdential = {
      "email": email,
      "password": password
    };

    String url = "${ApiEndpoints.baseUrl}/api/${ApiEndpoints.version}/users";
    print(url);
    Map jsonData = {
      "email": email,
      "password": password,
      "role": "customer",
      "firstname": firstname,
      "lastname": lastname,
    };
    try {
      response = await ApiCall.postApi(jsonData: jsonData, url: url);

      if (json.decode(response.body)["success"] as bool == true) {
        UserResponse successResponse = UserResponse.fromJson(response.body);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("userId", successResponse.data.id);

        Navigator.pushReplacementNamed(context, VerificationScreen.routeName,
            arguments: _userCerdential);
        ScaffoldMessenger.of(context)
            .showSnackBar(generalSnackBar(successResponse.message, context));
      } else {
        var errMessage = json.decode(response.body)["message"];
        generalAlertDialog(context, errMessage);
      }

      showRegisterSpinner = false;
      notifyListeners();
    } catch (e) {
      generalAlertDialog(context, e.toString());
    }
  }

  Future<void> getUserInfo(
    context,
  ) async {
    late Response response;
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userId = pref.getString("userId");
    String url =
        "${ApiEndpoints.baseUrl}/api/${ApiEndpoints.version}/users/$userId";
    print(url);
    String? token = pref.getString('accessToken');
    print("From on getCategory in products!!!");
    print(token);
    print("From on getCategory in products!!!");
    try {
      response = await ApiCall.getApi(
        url,
        headerValue: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      if (json.decode(response.body)["success"] as bool == true) {
        UserResponse successResponse = UserResponse.fromJson(response.body);

        userInfoResponse = successResponse;
      } else {
        var errMessage = json.decode(response.body)["message"];
        generalAlertDialog(context, errMessage);
      }

      notifyListeners();
    } catch (e) {
      generalAlertDialog(context, e.toString());
    }
  }

  Future<void> verifyUser(context,
      {required String email,
      required String password,
      required String code}) async {
    showVerifyCodeSpinner = true;
    notifyListeners();
    late Response response;
    String url =
        "${ApiEndpoints.baseUrl}/api/${ApiEndpoints.version}/auth/verify";
    print(url);
    Map jsonData = {
      "verificationCode": code,
      "email": email,
    };
    print("From on clickSendCode AuthCon!!!=>" + email + password + code);
    try {
      response = await ApiCall.putApi(
        jsonData: jsonData,
        url: url,
      );

      var responseBody = json.decode(response.body);
      if (responseBody["success"] as bool == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          generalSnackBar(responseBody["message"], context),
        );
        loginUser(context, email: email, password: password);
      } else {
        var errMessage = responseBody["message"];
        generalAlertDialog(context, errMessage);
      }

      showVerifyCodeSpinner = false;
      notifyListeners();
    } catch (e) {
      generalAlertDialog(context, e.toString());
    }
  }
}
