import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomato_app/api/api_call.dart';
import 'package:tomato_app/api/api_endpoints.dart';
import 'package:tomato_app/models/login_response.dart';
import 'package:tomato_app/models/register_response.dart';
import 'package:tomato_app/screens/home.dart';
import 'package:tomato_app/screens/verification-screen.dart';

class AuthController extends ChangeNotifier {
  bool showLoginSpinner = false;
  bool showRegisterSpinner = false;
  bool showVerifyCodeSpinner = false;



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
        // print("preferences !!!! ${preferences.getString("accessToken")}");
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        ScaffoldMessenger.of(context)
            .showSnackBar(_generalSnackBar(successResponse.message, context));
      } else {
        var errMessage = json.decode(response.body)["message"];
        _generalAlertDialog(context, errMessage);
      }

      showLoginSpinner = false;
      notifyListeners();
    } catch (e) {
      _generalAlertDialog(context, e.toString());
    }
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
        RegisterResponse successResponse =
            RegisterResponse.fromJson(response.body);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        print(successResponse.data.verificationCode);

        Navigator.pushReplacementNamed(context, VerificationScreen.routeName,
            arguments: _userCerdential);
        ScaffoldMessenger.of(context)
            .showSnackBar(_generalSnackBar(successResponse.message, context));
      } else {
        var errMessage = json.decode(response.body)["message"];
        _generalAlertDialog(context, errMessage);
      }

      showRegisterSpinner = false;
      notifyListeners();
    } catch (e) {
      _generalAlertDialog(context, e.toString());
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
      response = await ApiCall.postApi(
        jsonData: jsonData,
        url: url,
      );
      var responseBody = json.decode(response.body);
      if (responseBody["success"] as bool == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          _generalSnackBar(responseBody["message"], context),
        );
        // onClickLoginBtn(context, email: email, password: password);
      } else {
        var errMessage = responseBody["message"];
        _generalAlertDialog(context, errMessage);
      }

      showVerifyCodeSpinner = false;
      notifyListeners();
    } catch (e) {
      _generalAlertDialog(context, e.toString());
    }
  }

  SnackBar _generalSnackBar(successMessage, context) {
    return SnackBar(
      duration: Duration(milliseconds: 1500),
      backgroundColor: Colors.white.withOpacity(0.9),
      content: Container(
        height: 60,
        alignment: Alignment.center,
        child: Text(
          successMessage,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Theme.of(context).accentColor,
              ),
        ),
      ),
    );
  }

  Future<dynamic> _generalAlertDialog(context, errMessage) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(errMessage),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showLoginSpinner = false;
                    notifyListeners();
                  },
                  child: Text("Okay"),
                )
              ],
            ));
  }
}
