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
