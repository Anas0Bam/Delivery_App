import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationModel {
  LatLng initialCameraPosition;
  LatLng selectedLocation;

  LocationModel({
    required this.initialCameraPosition,
    required this.selectedLocation,
  });
}
