import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

dynamic getPosition() async {
  bool serviceEnabled;
  bool permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return 'Location services are disabled.';
  }

  permission = await Permission.location.isDenied;
  if (permission) {
    await Permission.location.request();
    permission = await Permission.location.isDenied;
    if (!permission) {
      return 'Location permissions are denied';
    }
  }
  permission = await Permission.location.isPermanentlyDenied;
  if (permission) {
    return 'Location permissions are permanently denied, we cannot request permissions.';
  }
  return Geolocator.getCurrentPosition();
}
