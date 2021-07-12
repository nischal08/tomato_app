import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomato_app/api/api_call.dart';
import 'package:tomato_app/models/login_response.dart';
import 'package:tomato_app/models/register_response.dart';
import 'package:tomato_app/screens/home.dart';

class AuthController extends ChangeNotifier {
  bool showLoginSpinner = false;
  bool showRegisterSpinner = false;
  Future<void> onClickLoginBtn(context,
      {required String email, required String password}) async {
    showLoginSpinner = true;
    notifyListeners();
    late Response response;
    try {
      response = await ApiCall.signIn(email, password);

      if (json.decode(response.body)["success"] as bool == true) {
        LoginResponse successResponse = LoginResponse.fromJson(response.body);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("accessToken", successResponse.data.accessToken);
        preferences.setString(
            "refreshToken", successResponse.data.refreshToken);
        // print("preferences !!!! ${preferences.getString("accessToken")}");
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(milliseconds: 1500),
            backgroundColor: Colors.white.withOpacity(0.9),
            content: Container(
              height: 60,
              alignment: Alignment.center,
              child: Text(
                successResponse.message,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Theme.of(context).accentColor,
                    ),
              ),
            ),
          ),
        );
      } else {
        var errMessage = json.decode(response.body)["message"];
        showDialog(
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

      showLoginSpinner = false;
      notifyListeners();
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text(e.toString()),
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

  Future<void> onClickRegisterBtn(
    context, {
    required String email,
    required String password,
    required String firstname,
    required String lastname,
  }) async {
    showLoginSpinner = true;
    notifyListeners();
    late Response response;
    try {
      response = await ApiCall.signUp(
        email: email,
        firstName: firstname,
        lastName: lastname,
        password: password,
      );

      if (json.decode(response.body)["success"] as bool == true) {
        RegisterResponse successResponse = RegisterResponse.fromJson(response.body);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        // preferences.setString("accessToken", successResponse.data.accessToken);
        // preferences.setString(
        //     "refreshToken", successResponse.data.refreshToken);
        // print("preferences !!!! ${preferences.getString("accessToken")}");
        // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     duration: Duration(milliseconds: 1500),
        //     backgroundColor: Colors.white.withOpacity(0.9),
        //     content: Container(
        //       height: 60,
        //       alignment: Alignment.center,
        //       child: Text(
        //         successResponse.message,
        //         style: Theme.of(context).textTheme.headline5!.copyWith(
        //               color: Theme.of(context).accentColor,
        //             ),
        //       ),
        //     ),
        //   ),
        // );
      } else {
        var errMessage = json.decode(response.body)["message"];
        showDialog(
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

      showLoginSpinner = false;
      notifyListeners();
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text(e.toString()),
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
}
