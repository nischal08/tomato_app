import 'package:http/http.dart';

class ApiCall {
  static Future<Response> postApi({required Map jsonData,required String url}) async {
   
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

 
  
}
