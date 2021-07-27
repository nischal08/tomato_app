import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
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
  late GoogleMapController _googleMapController;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Map"),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
              icon: Icon(Icons.check),
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
            onMapCreated: (controller) => _googleMapController = controller,
            myLocationButtonEnabled: false,
            circles:{},
            //  widget.direction==null
            //     ? {}
            //     : {
            //         Circle(strokeWidth: 2,
            //         strokeColor: Colors.blue,
            //           circleId: CircleId("raduis"),
            //           center: LatLng(
            //               widget.direction!.bounds.southwest.latitude,
            //               widget.direction!.bounds.southwest.longitude),
            //           radius: 2000,
            //           fillColor: Colors.blue.withOpacity(0.1),
            //         ),
            //       },
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
                : {
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
                    if (widget.userLocationData != null)
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
                  },
          ),
          if (widget.direction != null)
            Positioned(
              top: 20.0,
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
