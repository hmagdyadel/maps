import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<bool> checkAndRequestLocationService() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {}
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return false;
    } else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.always) {
        return false;
        // TODO: show error bar
      }
    }

    return true;
  }

  Future<Position> getLocation() async {
    return await Geolocator.getCurrentPosition();
  }
}
