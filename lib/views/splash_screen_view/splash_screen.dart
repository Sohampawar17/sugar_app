import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

import '../../router.router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool isLoggedIn = false;
  Future<void> _performAsyncOperations() async {
    final SharedPreferences prefs = await _prefs;
    Logger().i(prefs.getString("Cookie"));
    if (prefs.getString("Cookie") != null) {
      isLoggedIn = true;
    }
    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  void initState() {
    super.initState();
    _performAsyncOperations().then((_) {
      if (isLoggedIn) {
        Navigator.popAndPushNamed(context, Routes.homePageScreen);
      } else {
        Navigator.popAndPushNamed(context, Routes.loginViewScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Quant Sugar',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
