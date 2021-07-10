import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomato_app/api/api_call.dart';
import 'package:tomato_app/models/login_response.dart';
import 'package:tomato_app/screens/home.dart';

class AuthController extends ChangeNotifier {
  bool passwordVisibility = false;
  bool changebuttonAnimation = false;
  bool showSpinner = false;

  void onTogglePasswordVisibility() {
    print("password visbilty !!!");
    passwordVisibility = !passwordVisibility;
    notifyListeners();
  }

  Future<void> onClickLoginBtn(context,
      {required String email, required String password}) async {
    showSpinner = true;
    notifyListeners();
    late LoginResponse response;
    try {
      response = await ApiCall.signIn(email, password);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text('Error!!! ${e.toString()}'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showSpinner = false;
                      notifyListeners();
                    },
                    child: Text("Okay"),
                  )
                ],
              ));
    }
    if (response.success == true) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("accessToken", response.data.accessToken);
      preferences.setString("refreshToken", response.data.refreshToken);
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
              response.message,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: Theme.of(context).accentColor,
                  ),
            ),
          ),
        ),
      );
    }

    showSpinner = false;
    notifyListeners();
  }
}
