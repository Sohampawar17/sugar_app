import 'dart:convert';
import 'dart:io';

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
        apiVillageListGet,
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
    try {
      var dio = Dio();
      var response = await dio.request(
        apiFarmerListPost,
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
        Fluttertoast.showToast(msg: "UNABLE TO ADD FARMER!");
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error accoured $e ");
      Fluttertoast.showToast(msg: "Select Correct Village!");
      Logger().e(e);
    }
    return false;
  }

  Future<String> uploadDocs(File file) async {
    try {
      FormData data = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path,
          filename: generateUniqueFileName(file),
        ),
      });
      var dio = Dio();
      var response = await dio.request(
        apiUploadFilePost,
        options: Options(
          method: 'POST',
          headers: {'Cookie': await getTocken()},
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Logger().i(json.encode(response.data));
        String jsonString = json
            .encode(response.data); // Convert the response.data to JSON string
        Map<String, dynamic> jsonResponse = json.decode(jsonString);

// Extract the "file_url" from the jsonResponse
        String fileUrl = jsonResponse["message"]["file_url"];

        return fileUrl;
      } else {
        Logger().i(response.statusMessage);
      }
    } catch (e) {
      Logger().e(e);
    }

    return "";
  }
}
