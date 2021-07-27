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
    final response = await _dio.get(
        "https://maps.googleapis.com/maps/api/directions/json?",
        queryParameters: {
          'origin': "${origin.latitude},${origin.longitude}",
          'destination': "${destination.latitude},${destination.longitude}",
          'key':GOOGLE_API_KEY
        });
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
  }
}
