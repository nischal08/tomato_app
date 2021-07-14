import 'package:http/http.dart';

class ApiCall {
  static Future<Response> postApi(
      {required Map jsonData, required String url}) async {
    print(url);

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

  static Future<Response> getApi(String url) async {
    print(url);

    try {
      final Response response = await get(
        Uri.parse(url),
      );

      return response;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
