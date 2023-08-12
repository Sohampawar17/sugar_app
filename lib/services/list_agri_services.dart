import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../constants.dart';
import '../models/agri_list_model.dart';

class ListAgriService {
  Future<List<AgriListModel>> getAllCaneList() async {
    try {
      var headers = {'Cookie': await getTocken()};
      var dio = Dio();
      var response = await dio.request(
        apigetagrilist,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(json.encode(response.data));
        List<AgriListModel> agriList = List.from(jsonData['data'])
            .map<AgriListModel>((data) => AgriListModel.fromJson(data))
            .toList();
        return agriList;
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
