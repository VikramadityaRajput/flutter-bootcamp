// Gets the device's GPS coordinates.
//
// MOCK MODE: returns fixed coordinates (London) so the app runs on Chrome with
// no location permission. To go live, uncomment the real block and add
// `import 'package:geolocator/geolocator.dart';` plus location permissions.
class Location {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    // Simulate the delay of asking the OS for a GPS fix.
    await Future.delayed(const Duration(milliseconds: 500));

    // ---- REAL VERSION (needs GPS/browser permission) ----
    // Position position = await Geolocator.getCurrentPosition(
    //   desiredAccuracy: LocationAccuracy.low,
    // );
    // latitude = position.latitude;
    // longitude = position.longitude;

    // ---- MOCK VERSION: pretend we're in London ----
    latitude = 51.5;
    longitude = -0.12;
  }
}
