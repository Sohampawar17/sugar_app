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
    Logger().i("THERE YOU ARE!");
    Logger().i(position);
    setBusy(false);
    notifyListeners();
  }
}
