import 'package:eco_waste/screens/auth/login.dart';
import 'package:eco_waste/screens/auth/onboarding.dart';
import 'package:eco_waste/screens/auth/signup.dart';
import 'package:eco_waste/screens/auth/splashscreen.dart';

import 'package:eco_waste/screens/dashboard.dart';
import 'package:eco_waste/screens/homepage.dart';
import 'package:eco_waste/screens/blog.dart';

import 'package:eco_waste/screens/post_screen.dart';
import 'package:eco_waste/screens/profile.dart';
import 'package:eco_waste/screens/settings.dart';

import 'package:flutter/material.dart';

class AppRoutes {
  Map<String, Widget Function(BuildContext ctx)> routes =
      <String, WidgetBuilder>{
    '/': (ctx) => const SplashScreen(),
    '/onboarding': (ctx) => const OnboardingScreen(),
    '/signup': (ctx) => const SignUpScreen(),
    '/login': (ctx) => const LoginScreen(),
    '/dashboard': (ctx) => const DashBoard(),
    '/homepage': (ctx) => const HomePage(),
   
    '/blog': (ctx) =>  Blog(),
    '/settings': (ctx) => const Settings(),
    '/profile': (ctx) => const Profile(),
   


    '/postscreen':(ctx) => const PostScreen(),
  };
}
