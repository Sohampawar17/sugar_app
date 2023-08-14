import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:sugar_mill_app/models/Crop_Sampling.dart';

import '../constants.dart';
import '../models/agri_cane_model.dart';

class AddCropSmaplingServices {
  Future<bool> addCropsampling(CropSampling cropsampling) async {
    var data = json.encode({
      "data": cropsampling,
    });
    Logger().i(cropsampling.toString());
    try {
      var dio = Dio();
      var response = await dio.request(
        apiPostCropSampling,
        options: Options(
          method: 'POST',
          headers: {'Cookie': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Crop Smapling  Registerted Successfully");
        return true;
      } else {
        Fluttertoast.showToast(msg: "UNABLE TO Crop Smapling!");
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error accoured $e ");
      Logger().e(e);
    }
    return false;
  }

  Future<List<AgriCane>> fetchcanelistwithfilter() async {
    try {
      var headers = {'Cookie': await getTocken()};
      var dio = Dio();
      var response = await dio.request(
        '$apiBaseUrl/api/resource/Cane Master?fields=["vendor_code","grower_name","area","crop_type","crop_variety","plantattion_ratooning_date","area_acrs","plant_name","name"]&limit_page_length=99999',
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
