import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:sugar_mill_app/router.router.dart';
import 'package:sugar_mill_app/services/geolocation_service.dart';
import '../../services/login_success.dart';

class HomeViewModel extends BaseViewModel {
  List<String> villageList = [""];
  initialise(BuildContext context) async {
    villageList = await login().fetchVillages();
    if (villageList.isEmpty) {
      final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
      final SharedPreferences prefs = await prefs0;
      prefs.clear();
      if (context.mounted) {
        setBusy(false);
        Navigator.popAndPushNamed(context, Routes.loginViewScreen);
        Logger().i('logged out success');
      }
    }
  }

  void getGeoLocation() async {
    setBusy(true);
    notifyListeners();
    Position? position = await GeolocationService().determinePosition();
    Logger().i(position);
    Placemark? placemark = await GeolocationService().getPlacemarks(position);
    Fluttertoast.showToast(
        msg: placemark.toString(), toastLength: Toast.LENGTH_LONG);
    setBusy(false);
    notifyListeners();
  }

  void logout(BuildContext context) async {
    final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    prefs.clear();
    if (context.mounted) {
      Navigator.popAndPushNamed(context, Routes.loginViewScreen);
    }
  }
}
