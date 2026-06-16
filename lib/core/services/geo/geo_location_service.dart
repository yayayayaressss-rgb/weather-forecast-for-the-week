import 'package:geolocator/geolocator.dart';

class GeoLocationService {
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<LocationPermission> checkPermission() async {
    return await Geolocator.checkPermission();
  }

  Future<LocationPermission> requestPermission() async {
    return await Geolocator.requestPermission();
  }

  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.medium,
        distanceFilter: 100,
      ),
    );
  }

  Future<bool> isGeoAvailable() async {
    final isEnabled = await isLocationServiceEnabled();
    if (!isEnabled) return false;

    final permission = await checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<Position> getPositionSafely() async {
    final isAvailable = await isGeoAvailable();
    if (!isAvailable) {
      throw Exception('Geo location not available');
    }
    return await getCurrentPosition();
  }
}
