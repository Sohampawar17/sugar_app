import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class GeolocationService {
  Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      Logger().i("SOME SHEET HAPPENED");
      if (!serviceEnabled) {
        Fluttertoast.showToast(msg: 'Location Serices are disabled');
        Future.error('Location services are disabled.');
        return null;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Fluttertoast.showToast(msg: 'Location permissions are denied');
          Future.error('Location permissions are denied');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Fluttertoast.showToast(
            msg:
                'Location permissions are permanently denied, we cannot request permissions.');
        Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
        return null;
      }

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      return null;
    }
  }
}
