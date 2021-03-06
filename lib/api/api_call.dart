import 'dart:convert';

import 'package:http/http.dart';

class ApiCall {
  static Future<Response> postApi(
      {required jsonData,
      required String url,
      Map<String, String>? headerValue}) async {
    print(url);

    try {
      if (headerValue == null) {
        final Response response = await post(
          Uri.parse(url),
          body: jsonData,
        );
        return response;
      } else {
        final Response response = await post(
          Uri.parse(url),
          body: jsonData,
          headers: headerValue,
        );
        print(jsonDecode(response.body));
        return response;
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<Response> putApi(
      {required Map jsonData, required String url}) async {
    print(url);
    try {
      final Response response = await put(
        Uri.parse(url),
        body: jsonData,
      );
      return response;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<Response> getApi(String url,
      {Map<String, String>? headerValue}) async {
    print(url);
    try {
      final Response response = await get(Uri.parse(url), headers: headerValue);
      return response;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
