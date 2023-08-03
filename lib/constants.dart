import 'package:flutter/material.dart';
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
