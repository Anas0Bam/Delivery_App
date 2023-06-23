import 'package:deliver_app/Model/location-model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapController {
  final LocationModel model;

  MapController(this.model);

  Future<void> retrieveLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Denid Location");
      // Location services are not enabled, handle it accordingly
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Location permissions are still denied, handle it accordingly
        print("Denid Location");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Location permissions are permanently denied, handle it accordingly
      print("Denid Location");
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    print(position.latitude + position.longitude);
    model.initialCameraPosition = LatLng(position.latitude, position.longitude);
  }

  void onMapCreated(GoogleMapController controller) {
    // Handle map creation, if necessary
  }

  void onMapTap(LatLng tappedPosition) {
    model.selectedLocation = tappedPosition;

    // Do something with the selected location
    print('Selected Location: ${model.selectedLocation}');
  }
}



Future<void> retrieveLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    print("Denid Location");
    // Location services are not enabled, handle it accordingly
    return;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Location permissions are still denied, handle it accordingly
      print("Denid Location");
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Location permissions are permanently denied, handle it accordingly
    print("Denid Location");
    return;
  }

  Position position = await Geolocator.getCurrentPosition();
  print(position.latitude + position.longitude);
}
