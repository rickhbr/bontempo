import 'package:geolocator/geolocator.dart';

class Geolocation {
  static Future<Position> getUserPosition() async {
    Position? geolocation;
    LocationPermission permission;

    bool geolocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!geolocationEnabled) {
      geolocation = null;
    } else {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          geolocation = null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        geolocation = null;
      } else {
        try {
          geolocation = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.medium,
          );
        } catch (e) {
          geolocation = null;
        }
      }
    }

    return geolocation!;
  }
}
