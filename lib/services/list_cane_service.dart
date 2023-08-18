import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../constants.dart';
import '../models/cane_list_model.dart';

class ListCaneService {
  Future<List<CaneListModel>> getAllCaneList() async {
    try {
      var headers = {'Cookie': await getTocken()};
      var dio = Dio();
      var response = await dio.request(
        apifetchCaneList,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<CaneListModel> caneList = List.from(jsonData['data'])
            .map<CaneListModel>((data) => CaneListModel.fromJson(data))
            .toList();
        return caneList;
      } else {
        Logger().e(response.statusMessage);
        return [];
      }
    } catch (e) {
      Logger().e(e);
    }

    return [];
  }

  Future<List<CaneListModel>> getAllCaneListfilter(
      String query, int filter) async {
    try {
      var headers = {'Cookie': await getTocken()};

      var dio = Dio();
      var response = await dio.request(
        '$apiBaseUrl/api/resource/Cane Master?fields=["plantation_status","area","circle_office","name","grower_code","grower_name","plantattion_ratooning_date"]&filters=[["$query","like","$filter%"]]',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      Logger().i(apiBaseUrl);
      Logger().i(query);
      Logger().i(filter);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<CaneListModel> caneList = List.from(jsonData['data'])
            .map<CaneListModel>((data) => CaneListModel.fromJson(data))
            .toList();
        Logger().i(caneList);
        return caneList;
      } else {
        Logger().e(response.statusMessage);
        return [];
      }
    } catch (e) {
      Logger().e(e);
    }

    return [];
  }

  Future<List<CaneListModel>> getCaneListByNameFilter(
      String name, String village) async {
    try {
      var headers = {'Cookie': await getTocken()};
      var dio = Dio();
      var response = await dio.request(
        '$apiBaseUrl/api/resource/Cane Master?fields=["plantation_status","area","circle_office","name","grower_code","grower_name","plantattion_ratooning_date"]&filters=[["grower_name","like","$name%"],["season","like","$village%"]]',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<CaneListModel> farmersList = List.from(jsonData['data'])
            .map<CaneListModel>((data) => CaneListModel.fromJson(data))
            .toList();
        return farmersList;
      } else {
        Logger().e(response.statusMessage);
        return [];
      }
    } catch (e) {
      Logger().e(e);
    }

    return [];
  }
}
