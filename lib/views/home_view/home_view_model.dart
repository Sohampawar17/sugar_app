import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import 'package:sugar_mill_app/models/checkin.dart';
import 'package:sugar_mill_app/models/employee.dart';
import 'package:sugar_mill_app/router.router.dart';
import 'package:sugar_mill_app/services/chekin_Services.dart';
import 'package:sugar_mill_app/services/geolocation_service.dart';
import '../../services/login_success.dart';

class HomeViewModel extends BaseViewModel {
  Checkin checkindata = Checkin();
  Employee employee = Employee();
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  List<String> villageList = [""];
  List<Employee> empList = [];
  List<Checkin> checkinList = [];
  String? mobile;
  String? empname;
  String? empid;
  String? checkvalue;
  String? time;
  String? sharedempid;

  void logout(BuildContext context) async {
    final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    prefs.clear();
    if (context.mounted) {
      Navigator.popAndPushNamed(context, Routes.loginViewScreen);
    }
  }

  initialise(BuildContext context) async {
    setBusy(true);
    final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    mobile = prefs.getString("mobile");
    villageList = await login().fetchVillages();
    if (villageList.isEmpty) {
      final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
      final SharedPreferences prefs = await prefs0;
      prefs.clear();
      if (context.mounted) {
        Navigator.pushNamed(context, Routes.loginViewScreen);
      }
    }
    empList = await CheckinServices().fetchmobile(mobile ?? "");
    empname = empList[0].employeeName;
    notifyListeners();
    empid = empList[0].name;
    checkinList = await CheckinServices().fetchcheckindata(empid ?? "");
    setBusy(false);
    checkvalue = checkinList[0].logType;
    time = checkinList[0].time;
    notifyListeners();
    Logger().i(checkvalue);
    Logger().i(time);
  }

  void checkin(BuildContext context) async {
    bool res = false;
    setBusy(true);
    checkindata.employee = empid;
    checkindata.logType = "IN";
    checkindata.time = DateTime.now().toString();
    GeolocationService geolocationService = GeolocationService();
    Position? position = await geolocationService.determinePosition();
    if (position != null) {
      Placemark? placemark = await geolocationService.getPlacemarks(position);
      if (placemark != null) {
        // Extract properties from the placemark
        String formattedAddress =
            await geolocationService.getAddressFromCoordinates(
                    position.latitude, position.longitude) ??
                "";
        checkindata.latitude = position.latitude.toString();
        checkindata.longitude = position.longitude.toString();
        checkindata.deviceId = formattedAddress;
        Logger().i(checkindata.toJson().toString());
        res = await CheckinServices().addCheckin(checkindata);
        if (res) {
          if (context.mounted) {
            setBusy(false);

            checkinList = await CheckinServices().fetchcheckindata(empid ?? "");

            checkvalue = checkinList[0].logType;
            time = checkinList[0].time;
            notifyListeners();
            Navigator.pop(context);
            Fluttertoast.showToast(
              msg: "Check-$checkvalue Successfully!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.black87,
              fontSize: 16.0,
            );
          }
        }
      } else {
        // Handle case where placemark is null
        Fluttertoast.showToast(msg: 'Failed to get placemark');
        setBusy(false);
      }
    } else {
      // Handle case where obtaining location fails
      Fluttertoast.showToast(msg: 'Failed to get location');
      setBusy(false);
    }
    setBusy(false);
    notifyListeners();
  }

  void checkout(BuildContext context) async {
    bool res = false;
    setBusy(true);
    checkindata.employee = empid;
    checkindata.logType = "OUT";
    checkindata.time = DateTime.now().toString();
    GeolocationService geolocationService = GeolocationService();
    Position? position = await geolocationService.determinePosition();
    if (position != null) {
      // Get the placemark using the geolocation service
      Placemark? placemark = await geolocationService.getPlacemarks(position);
      if (placemark != null) {
        // Extract properties from the placemark
        String formattedAddress =
            await geolocationService.getAddressFromCoordinates(
                    position.latitude, position.longitude) ??
                "";
        checkindata.latitude = position.latitude.toString();
        checkindata.longitude = position.longitude.toString();
        checkindata.deviceId = formattedAddress;
        Logger().i(checkindata.toJson().toString());
        res = await CheckinServices().addCheckin(checkindata);
        if (res) {
          if (context.mounted) {
            setBusy(false);
            setBusy(false);
            checkinList = await CheckinServices().fetchcheckindata(empid ?? "");
            checkvalue = checkinList[0].logType;
            time = checkinList[0].time;
            notifyListeners();
            Navigator.pop(context);
            Fluttertoast.showToast(
              msg: "Check-$checkvalue Successfully!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.black87,
              fontSize: 16.0,
            );
          }
        }
      } else {
        // Handle case where placemark is null
        Fluttertoast.showToast(msg: 'Failed to get placemark');
        setBusy(false);
      }
    } else {
      // Handle case where obtaining location fails
      Fluttertoast.showToast(msg: 'Failed to get location');
      setBusy(false);
    }
    setBusy(false);
    notifyListeners();
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
}
