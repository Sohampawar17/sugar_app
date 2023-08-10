import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:sugar_mill_app/models/agri_cane_model.dart';
import '../constants.dart';

class AddAgriServices {
  Future<List<String>> fetchSeason() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        apifetchSeason,
        options: Options(
          method: 'GET',
          headers: {'Cookie': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = json.encode(response.data);
        Map<String, dynamic> jsonDataMap = json.decode(jsonData);
        List<dynamic> dataList = jsonDataMap["data"];
        Logger().i(dataList);
        List<String> namesList =
            dataList.map((item) => item["name"].toString()).toList();
        return namesList;
      }

      if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: "Unauthorized Access!");
        return ["401"];
      } else {
        Fluttertoast.showToast(msg: "Unable to fetch Villages");
        return [];
      }
    } catch (e) {
      Logger().e(e);
      Fluttertoast.showToast(msg: "Unauthorized Access!");
      return [];
    }
  }

  Future<List<AgriCane>> fetchcanelistwithfilter() async {
    try {
      var headers = {'Cookie': await getTocken()};
      var dio = Dio();
      var response = await dio.request(
        apifetchcanelistwithfilter,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        var jsonData = json.encode(response.data);
        Map<String, dynamic> jsonDataMap = json.decode(jsonData);
        List<dynamic> dataList = jsonDataMap['data'];
        List<AgriCane> Canelistwithfilter =
            dataList.map<AgriCane>((data) => AgriCane.fromJson(data)).toList();
        Logger().i(Canelistwithfilter);
        return Canelistwithfilter;
      } else {
        Logger().e(response.statusCode);
        Logger().e(response.statusMessage);
        return [];
      }
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }
}
