import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tomato_app/helper/location_helper.dart';
import 'package:tomato_app/models/directions_model.dart';

class DirectionsRepository {
  Dio _dio = Dio();

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    print("$origin  $destination");
    final response = await _dio.get(
        "https://maps.googleapis.com/maps/api/directions/json?",
        queryParameters: {
          'destination': "${destination.latitude},${destination.longitude}",
          'origin': "${origin.latitude},${origin.longitude}",
          'key': GOOGLE_API_KEY
        });
    if (response.statusCode == 200) {
      print(response.data);
      return Directions.fromMap(response.data);
    }
  }
}
