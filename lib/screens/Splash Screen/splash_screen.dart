import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speech_to_text_tutorial/screens/Navigation/main_navigation_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return  SafeArea(
        child: Container(
          color: Colors.black,
          width: screenWidth,
          height: screenHeight,
          child: AnimatedSplashScreen(
            backgroundColor: Colors.black,
            splashIconSize: screenWidth,
            pageTransitionType: PageTransitionType.bottomToTop,
            duration: 3000,
            splash: Image.asset(
              'assets/icons/logo.png',
              fit: BoxFit.cover,
            ),
            nextScreen: const MainNavigationScreen(),
          ),
        ),

    );
  }
}
