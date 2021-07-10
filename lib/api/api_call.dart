import 'dart:convert';

import 'package:http/http.dart';
import 'package:tomato_app/api/api_endpoints.dart';
import 'package:tomato_app/models/login_response.dart';

class ApiCall {
  static Future<LoginResponse> signIn(String email, String password) async {
    String url =
        "${ApiEndpoints.baseUrl}/api/${ApiEndpoints.version}/auth/login";
    print(url);
    Map jsonData = {
      "email": email,
      "password": password,
    };
    try {
      final Response response = await post(
        Uri.parse(url),
        body: jsonData,
      );

      return LoginResponse.fromJson(response.body);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
