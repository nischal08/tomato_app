import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyDpeLIspvCJaOwdykG7o1ER-0lX8_XSItg';

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=&$longitude,$latitude&zoom=16&size=1080x320&maptype=roadmap&markers=color:red%7Clabel:N%7C$latitude,$longitude&key=$GOOGLE_API_KEY";
  }

  static Future<String> getPlaceAddress(
      {required double longitude, required double latitude}) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GOOGLE_API_KEY';
    print(url);
    final response = await http.get(
      Uri.parse(url),
    );
    return jsonDecode(response.body)['results'][0]['formatted_address'];
  }
}
