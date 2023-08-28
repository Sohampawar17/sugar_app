import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:sugar_mill_app/models/agri_cane_model.dart';
import '../constants.dart';
import '../models/Agri.dart';

class AddAgriServices {
  Future<bool> updateAgri(Agri agri) async {
    try {
      // var data = json.encode({farmer});
      Logger().i(agri.name.toString());
      var dio = Dio();
      var response = await dio.request(
        '$apiBaseUrl/api/resource/Agriculture Development/${agri.name}',
        options: Options(
          method: 'PUT',
          headers: {'Cookie': await getTocken()},
        ),
        data: agri.toJson(),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Agriculture development Updated");
        return true;
      } else {
        Fluttertoast.showToast(
            msg: "UNABLE TO UPDATE Agriculture development!");
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error accoured $e ");
      Logger().e(e);
    }
    return false;
  }

  Future<Agri?> getAgri(String id) async {
    try {
      var dio = Dio();
      var response = await dio.request(
        '$apiBaseUrl/api/resource/Agriculture Development/$id',
        options: Options(
          method: 'GET',
          headers: {'Cookie': await getTocken()},
        ),
      );

      if (response.statusCode == 200) {
        Logger().i(response.data["data"]);
        return Agri.fromJson(response.data["data"]);
      } else {
        // print(response.statusMessage);
        return null;
      }
    } catch (e) {
      Logger().i(e);
      Fluttertoast.showToast(msg: "Error while fetching user");
    }
    return null;
  }

  Future<bool> addAgri(Agri agri) async {
    var data = json.encode({
      "data": agri,
    });
    Logger().i(agri.toString());
    try {
      var dio = Dio();
      var response = await dio.request(
        apiListagri,
        options: Options(
          method: 'POST',
          headers: {'Cookie': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Agriculture Development Registerted Successfully");
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO Agriculture Development!");
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error accoured $e ");
      Logger().e(e);
    }
    return false;
  }

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

  Future<List<String>> fetchdosetype() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        '$apiBaseUrl/api/resource/Dose Type?filters=[["crop_type","=","Plantation"]]&fields=["dose","fertilize_details.quantity","fertilize_details.fertilize_name"]',
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
        Fluttertoast.showToast(msg: "Unable to fetch dose type");
        return [];
      }
    } catch (e) {
      Logger().e(e);
      Fluttertoast.showToast(msg: "Unauthorized Access!");
      return [];
    }
  }

  Future<List<AgriCane>> fetchcanelistwithfilter(String season) async {
    try {
      var headers = {'Cookie': await getTocken()};
      var dio = Dio();
      var response = await dio.request(
        '$apiBaseUrl/api/resource/Cane Master?fields=["vendor_code","grower_name","area","crop_type","crop_variety","plantattion_ratooning_date","area_acrs","plant_name","name","soil_type"]&filters=[["season","=","$season"]]&limit_page_length=99999',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = json.encode(response.data);
        Map<String, dynamic> jsonDataMap = json.decode(jsonData);
        List<dynamic> dataList = jsonDataMap['data'];
        List<AgriCane> canelistwithfilter =
            dataList.map<AgriCane>((data) => AgriCane.fromJson(data)).toList();
        Logger().i(canelistwithfilter);
        return canelistwithfilter;
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
