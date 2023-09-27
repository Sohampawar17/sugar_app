import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../constants.dart';
import '../models/employee.dart';

class CheckinServices {
  Future<List<Employee>> fetchmobile(String mobile) async {
    try {
      var headers = {'Cookie': await getTocken()};
      var dio = Dio();
      var response = await dio.request(
        '$apiBaseUrl/api/resource/Employee?filters=[["cell_number","=","$mobile"]]&fields=["employee_name","name"]',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        var jsonData = json.encode(response.data);
        Map<String, dynamic> jsonDataMap = json.decode(jsonData);
        List<dynamic> dataList = jsonDataMap['data'];
        List<Employee> canelistwithfilter =
            dataList.map<Employee>((data) => Employee.fromJson(data)).toList();
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
