import 'package:deliver_app/Model/neighborhood-model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider {
  late Position _position;
  bool _isPermissionGranted = false;

  Position get position => _position;

  bool get isPermissionGranted => _isPermissionGranted;

  Future<bool> checkAndRequestPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, handle it accordingly
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Location permissions are still denied, handle it accordingly
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Location permissions are permanently denied, handle it accordingly
      return false;
    }

    return true;
  }

  Future<Neighborhood> retrieveLocation() async {
    while (true) {
      try {
        _position = await Geolocator.getCurrentPosition();
        final List<Placemark> placemarks = await placemarkFromCoordinates(
            _position.latitude, _position.longitude,
            localeIdentifier: 'ar'); // Specify Arabic locale
        if (placemarks.isNotEmpty) {
          final Placemark placemark = placemarks.first;
          final String neighborhood = placemark.subLocality ?? '';
          final String street = placemark.thoroughfare ?? '';
          // Do something with the neighborhood and street information
          print('Neighborhood: $neighborhood');
          print('Street: $street');
          return Neighborhood(neighborhood, street);
          break;
        }
        break;
      } catch (e) {}
    }
    return Neighborhood("0","0");
  }
}
