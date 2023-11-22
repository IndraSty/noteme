import 'package:flutter/material.dart';
import 'package:noteme/constant/color_constant.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Image.asset('assets/images/logo-white.png'),
      ),
    );
  }
}
