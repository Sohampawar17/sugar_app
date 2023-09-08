import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../router.router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
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

  double opacity = 1.0; // Initial opacity for fade-out animation

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

    // Start the fade-out animation after 2 seconds (adjust timing as needed)
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        opacity = 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double fontSize = screenWidth * 0.05;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: CachedNetworkImageProvider(
                'https://images.unsplash.com/photo-1468787737698-f5c03f0570dd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1930&q=80',
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 500),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  opacity: opacity,
                  duration:
                      const Duration(seconds: 3), // Adjust duration as needed
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 500),
                    child: Text(
                      'Venkateshwara Power Project',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
