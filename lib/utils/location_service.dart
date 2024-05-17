import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<void> checkAndRequestLocationService() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw LocationServiceException();
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      throw LocationPermissionException();
    } else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.always) {
        throw LocationPermissionException();
      }
    }
  }

  Future<Position> getLocation() async {
    await checkAndRequestLocationService();
    return await Geolocator.getCurrentPosition();
  }
}

class LocationServiceException implements Exception {}

class LocationPermissionException implements Exception {}
