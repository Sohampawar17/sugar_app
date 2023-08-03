import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:sugar_mill_app/constants.dart';
import 'package:sugar_mill_app/models/farmer.dart';

class AddFarmerService {
  Future<List<String>> fetchVillages() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        'http://deverpvppl.erpdata.in/api/resource/Village',
        options: Options(
          method: 'GET',
          headers: {'Cookie': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = json.encode(response.data);
        Map<String, dynamic> jsonDataMap = json.decode(jsonData);
        List<dynamic> dataList = jsonDataMap["data"];
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

  Future<bool> addFarmer(FarmerData farmerData) async {
    var data = json.encode({
      "data": farmerData,
    });

    print(data);
    try {
      var dio = Dio();
      var response = await dio.request(
        'http://deverpvppl.erpdata.in/api/resource/Farmer List',
        options: Options(
          method: 'POST',
          headers: {'Cookie': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "FARMER ADDED");
        return true;
      } else {
        Fluttertoast.showToast(msg: "FARMER FUCKED UP!");
        return false;
      }
    } catch (e) {
      Logger().e(e);
    }
    return false;
  }
}
