import 'dart:async';

import 'package:eco_waste/utils/colors.dart';
import 'package:eco_waste/utils/images.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   Timer(Duration(seconds: 3), () {
  //     Navigator.pushNamed(context, '/onboarding');
  //   });

  //   super.initState();
  // }
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, '/onboarding');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Text(
          'ECOWASTE',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
    );
  }
}
