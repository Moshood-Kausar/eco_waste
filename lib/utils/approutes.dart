import 'package:eco_waste/auth/login.dart';
import 'package:eco_waste/auth/onboarding.dart';
import 'package:eco_waste/auth/signup.dart';
import 'package:eco_waste/auth/splashscreen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  Map<String, Widget Function(BuildContext ctx)> routes =
      <String, WidgetBuilder>{
    '/': (ctx) => const SplashScreen(),
    '/onboarding': (ctx) => const OnboardingScreen(),
     '/signup': (ctx) => const SignUpScreen(),
      '/login': (ctx) => const LoginScreen(),

    //'/homepage':(ctx) => const HomePage(),
  };
}
