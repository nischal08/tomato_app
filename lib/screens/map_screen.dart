import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/controller/auth.dart';
import 'package:tomato_app/controller/restaurants.dart';
import 'package:tomato_app/models/directions_model.dart';
import 'package:tomato_app/models/place_location.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;
  final LocationData? userLocationData;
  final Directions? direction;

  const MapScreen({
    Key? key,
    this.initialLocation =
        const PlaceLocation(latitude: 27.7108, longitude: 85.3433),
    this.isSelecting = false,
    this.userLocationData,
    this.direction,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
              icon: Icon(Icons.check, color: Colors.black),
            )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            polylines: {
              if (widget.direction != null)
                Polyline(
                  polylineId: const PolylineId('overview_polyline'),
                  color: Colors.red,
                  width: 5,
                  points: widget.direction!.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                ),
            },
            zoomGesturesEnabled: true,
            myLocationButtonEnabled: false,
            circles: widget.direction == null
                ? {}
                : {
                    Circle(
                      visible: true,
                      strokeWidth: 2,
                      strokeColor: Colors.blue,
                      circleId: CircleId("free-delivery"),
                      center: LatLng(
                          widget.direction!.bounds.northeast.latitude,
                          widget.direction!.bounds.southwest.longitude),
                      radius: 200,
                      fillColor: Colors.blue.withOpacity(0.1),
                    ),
                    Circle(
                      strokeWidth: 5,
                      strokeColor: Colors.red,
                      circleId: CircleId("delivery-raduis"),
                      center: LatLng(
                          widget.direction!.bounds.northeast.latitude,
                          widget.direction!.bounds.southwest.longitude),
                      radius: 3000,
                    ),
                  },
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                widget.initialLocation.latitude,
                widget.initialLocation.longitude,
              ),
              zoom: 16,
            ),
            onTap: widget.isSelecting ? _selectLocation : null,
            markers: (_pickedLocation == null && widget.isSelecting)
                ? {}
                : widget.userLocationData != null
                    ? {
                        Marker(
                          markerId: MarkerId("venderLoc"),
                          infoWindow: InfoWindow(
                            title: Provider.of<Restaurants>(context)
                                .restaurantInfoResponse!
                                .data
                                .name,
                          ),
                          position: _pickedLocation ??
                              LatLng(
                                widget.initialLocation.latitude,
                                widget.initialLocation.longitude,
                              ),
                        ),
                        Marker(
                          icon: BitmapDescriptor.defaultMarkerWithHue(200),
                          markerId: MarkerId("userLoc"),
                          infoWindow: InfoWindow(
                              title:
                                  "${Provider.of<Auth>(context).userInfoResponse!.data.firstname} Location"),
                          position: LatLng(
                            widget.userLocationData!.latitude!,
                            widget.userLocationData!.longitude!,
                          ),
                        ),
                      }
                    : {
                        Marker(
                          markerId: MarkerId("Your Location"),
                          infoWindow: InfoWindow(
                            title: "Your Location",
                          ),
                          position: _pickedLocation ??
                              LatLng(
                                widget.initialLocation.latitude,
                                widget.initialLocation.longitude,
                              ),
                        ),
                      },
          ),
          if (widget.direction != null)
            Positioned(
              top: 60.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(
                  '${widget.direction!.totalDistance}, ${widget.direction!.totalDuration}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
