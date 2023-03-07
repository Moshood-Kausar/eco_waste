import 'package:eco_waste/utils/approutes.dart';
import 'package:eco_waste/utils/colors.dart';
import 'package:eco_waste/utils/controller_binding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EcoWaste',
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          primaryColor: AppColor.primary,
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              toolbarHeight: 70,
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: false,
              titleTextStyle: TextStyle(
                  color: AppColor.txtBlack,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
              iconTheme: IconThemeData(color: AppColor.txtBlack))
//platform: TargetPlatform.iOS
          ),
      initialBinding: ControllerBinding(),
      debugShowCheckedModeBanner: false,
      routes: AppRoutes().routes,
    );
  }
}
