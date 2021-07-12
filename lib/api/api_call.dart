import 'package:http/http.dart';
import 'package:tomato_app/api/api_endpoints.dart';

class ApiCall {
  static Future<Response> signIn(String email, String password) async {
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

      return response;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<Response> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    String url = "${ApiEndpoints.baseUrl}/api/${ApiEndpoints.version}/users";
    print(url);
    Map jsonData = {
      "email": email,
      "password": password,
      "role": "customer",
      "firstname": firstName,
      "lastname": lastName,
    };
    try {
      final Response response = await post(
        Uri.parse(url),
        body: jsonData,
      );
      print("Response from api call signUp: ${response.body}");
      return response;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
