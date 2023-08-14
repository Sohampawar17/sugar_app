import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:shared_preferences/shared_preferences.dart';

getHeight(context) => (MediaQuery.of(context).size.height);

getWidth(context) => (MediaQuery.of(context).size.width);

Color lightBlack = Colors.black.withOpacity(0.5);
String name = "Quant Sugar";
const kAadharpdf = "AadharCard";
const kPanpdf = "PanCard";
const kBankpdf = "BankPassbook";
const kConcentpdf = "ConcentLetter";
const apiBaseUrl = "http://deverpvppl.erpdata.in";

// api usrls

String apifetchSeason =
    '$apiBaseUrl/api/resource/Season?filters=[["disabled","=","0"]]';
String apifetchPlant = '$apiBaseUrl/api/resource/Branch';
//farmer List
String apiVillageListGet = '$apiBaseUrl/api/resource/Village';
String apiBankListGet = '$apiBaseUrl/api/resource/Bank';
String apiFarmerListPost = '$apiBaseUrl/api/resource/Farmer List';
String apiUploadFilePost = '$apiBaseUrl/api/method/upload_file';
String apiFarmerAllListGet =
    "$apiBaseUrl/api/resource/Farmer List?order_by=creation desc&limit_page_length=20&fields=[\"supplier_name\",\"village\",\"name\",\"workflow_state\",\"circle_office\"]";
String apitFilterOnFarmerListGet =
    "$apiBaseUrl/api/resource/Farmer List?order_by=creation desc&limit_page_length=20&fields=[\"supplier_name\",\"village\",\"name\",\"circle_office\",\"existing_supplier_code\"]&filters=[[\"village\",  \"like\", \"bed%\" ],[\"supplier_name\",  \"like\", \"abhi%\" ]]";
String apiLoginGet = '$apiBaseUrl/api/method/login';
//Cane Registration
String apifetchCaneList =
    '$apiBaseUrl/api/resource/Cane Master?fields=["plantation_status","area","circle_office","name","grower_code","grower_name","plantattion_ratooning_date"]';
String apiFarmerListGetwithfilter =
    '$apiBaseUrl/api/resource/Farmer List?fields=["supplier_name","existing_supplier_code","name"]&filters=[["workflow_state","=","approved"],["is_farmer","=",1]]&limit_page_length=999999';
String apiCaneRegistration = '$apiBaseUrl/api/resource/Cane Master';
String apifetchroute =
    '$apiBaseUrl/api/resource/Route?fields=["route","distance_km","name"]&limit_page_length=99999';
String apifetchcanevariety =
    '$apiBaseUrl/api/resource/Cane Variety?limit_page_length=50';
String apifetchplantationsystem = '$apiBaseUrl/api/resource/Plantation System';
String apifetchseedmaterial = '$apiBaseUrl/api/resource/Seed Material Used';
String apifetchirrigationmethod = '$apiBaseUrl/api/resource/Irrigation Method';
String apifetchcrptype = '$apiBaseUrl/api/resource/Crop Type';
String apifetchirrigationsource = '$apiBaseUrl/api/resource/Irrigation Source';
String apifetchsoiltype = '$apiBaseUrl/api/resource/Soil Type';

///Agri
String apifetchcanelistwithfilter =
    '$apiBaseUrl/api/resource/Cane Master?fields=["vendor_code","grower_name","area","crop_type","crop_variety","plantattion_ratooning_date","area_acrs","plant_name","name"]&filters=[["season","=",""]]&limit_page_length=99999';
String apiListagri = '$apiBaseUrl/api/resource/Agriculture Development';
String apigetagrilist =
    '$apiBaseUrl/api/resource/Agriculture Development?fields=["crop_type","crop_variety","date","area","village","name"]';
////Crop Sampling
String apiPostCropSampling = "$apiBaseUrl/api/resource/Crop Sampling";
String apiListSampling =
    '$apiBaseUrl/api/resource/Crop Sampling?fields=["id","season","plantation_status","plant_name","form_number","name"]';

///functions
Future<Map<String, String>> getTocken() async {
  final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
  final SharedPreferences prefs = await prefs0;
  String cookies = prefs.getString("Cookie") ?? "";
  String fresponse = cookies;

  String? sid = getValueFromResponse(fresponse, 'sid');
  String? systemUser = getValueFromResponse(fresponse, 'system_user');
  String? fullName = getValueFromResponse(fresponse, 'full_name');
  String? userId = getValueFromResponse(fresponse, 'user_id');
  String? userImage = getValueFromResponse(fresponse, 'user_image');

  String formattedString = 'full_name=${Uri.decodeComponent(fullName)}; '
      'sid=$sid; '
      'system_user=$systemUser; '
      'user_id=$userId; '
      'user_image=$userImage';

  return {'Cookie': formattedString};
}

String getValueFromResponse(String response, String key) {
  RegExp regex = RegExp('$key=([^;,]+)');
  Match? match = regex.firstMatch(response);
  return match != null ? match.group(1) ?? '' : '';
}

String generateUniqueFileName(File file) {
  // Get the original file name and extension
  String originalFileName = file.path.split('/').last;
  String extension = originalFileName.split('.').last;

  // Generate a unique identifier (You can use any method you prefer)
  String uniqueId = DateTime.now().millisecondsSinceEpoch.toString();

  // Combine the unique identifier with the original extension
  String uniqueFileName = '$uniqueId.$extension';

  return uniqueFileName;
}

bool isImage(File file) {
  List<String> imageExtensions = ['.png', '.jpg', '.jpeg', '.gif', '.bmp'];
  String extension = file.path.split('.').last.toLowerCase();
  return imageExtensions.contains(extension);
}

bool isPDF(File file) {
  String extension = file.path.split('.').last.toLowerCase();
  return extension == '.pdf';
}

Future<File?> compressFile(File file) async {
  // Get the file path.
  final filePath = file.absolute.path;

  // Get the file extension.
  final fileExtension = filePath.split('.').last;

  // Create a new file name with the extension "_compressed".
  final compressedFileName =
      filePath.replaceAll(fileExtension, '_compressed.$fileExtension');

  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    compressedFileName,
    quality: 60,
    // rotate: 180,
  );

  return fileFromXFile(result ?? XFile(""));
}

// Convert an XFile object to a File object.
File fileFromXFile(XFile xfile) {
  // Get the file path.
  final filePath = xfile.path;

  // Create a File object.
  final file = File(filePath);

  return file;
}
