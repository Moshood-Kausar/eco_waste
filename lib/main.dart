import 'package:eco_waste/utils/approutes.dart';
import 'package:eco_waste/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dogphy',
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          primaryColor: AppColor.primary,
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: true,
              titleTextStyle: TextStyle(color: AppColor.txtBlack, fontSize:18, fontWeight: FontWeight.w600),
              iconTheme: IconThemeData(color: AppColor.txtBlack))
//platform: TargetPlatform.iOS
          ),
      debugShowCheckedModeBanner: false,
      routes: AppRoutes().routes,
    );
  }
}
