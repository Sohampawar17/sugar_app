import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
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
    return Scaffold(
      backgroundColor: Colors.blue, // Set the background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextKit(
              // Use AnimatedTextKit for text animation
              animatedTexts: [
                TyperAnimatedText(
                  'Quant Sugar',
                  textStyle: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text color
                  ),
                ),
              ],
              totalRepeatCount: 1, // Animation repeat count
              pause:
                  const Duration(milliseconds: 1000), // Pause between animation
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
