import 'package:eco_web/services/controller_binding.dart';
import 'package:eco_web/utils/web_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Eco-Waste',

      //home: SignIn(),
      routes: WebRoutes().routes,
      initialBinding: ControllerBinding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
