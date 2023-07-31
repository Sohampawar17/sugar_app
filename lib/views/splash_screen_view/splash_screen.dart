import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:sugar_mill_app/views/login_view/login_view_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: const Text(
        'SUGAR MILL',
        style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      nextScreen: LoginViewScreen(
        key: key,
      ),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor:
          Colors.blue, // You can choose any background color you like
    );
  }
}
