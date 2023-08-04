import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:sugar_mill_app/constants.dart';
import 'package:sugar_mill_app/models/farmrs_list_model.dart';

class ListFarmersService {
  Future<List<FarmersListModelData>> getAllFarmersList() async {
    try {
      var headers = {'Cookie': await getTocken()};
      var dio = Dio();
      var response = await dio.request(
        'http://deverpvppl.erpdata.in/api/resource/Farmer List?fields=["supplier_name","village","name"]',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<FarmersListModelData> farmersList = List.from(jsonData['data'])
            .map<FarmersListModelData>(
                (data) => FarmersListModelData.fromJson(data))
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

  Future<List<FarmersListModelData>> getFarmersListByFilter(
      String query, String filter) async {
    print(
        "http://deverpvppl.erpdata.in/api/resource/Farmer List?fields=[\"supplier_name\",\"village\",\"name\",\"circle_office\"]&filters=[[\"$filter\",\"like\",\"$query\"]]");
    try {
      var headers = {'Cookie': await getTocken()};
      var dio = Dio();
      var response = await dio.request(
        // "http://deverpvppl.erpdata.in/api/resource/Farmer List?fields=['supplier_name','village','name','circle_office']&filters=[['$filter','like','$query'']]",
        "http://deverpvppl.erpdata.in/api/resource/Farmer List?fields=[\"supplier_name\",\"village\",\"name\",\"circle_office\"]&filters=[[\"$filter\",\"like\",\"$query%\"]]",
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<FarmersListModelData> farmersList = List.from(jsonData['data'])
            .map<FarmersListModelData>(
                (data) => FarmersListModelData.fromJson(data))
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
