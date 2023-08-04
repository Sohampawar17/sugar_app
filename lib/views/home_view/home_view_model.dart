import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/services/geolocation_service.dart';

class HomeViewModel extends BaseViewModel {
  initialise() {}

  void getGeoLocation() async {
    setBusy(true);
    notifyListeners();
    Position? position = await GeolocationService().determinePosition();
    Logger().i(position);
    Placemark placemark = await GeolocationService().getPlacemarks(position);
    Fluttertoast.showToast(
        msg: placemark.toString(), toastLength: Toast.LENGTH_LONG);
    setBusy(false);
    notifyListeners();
  }
}
