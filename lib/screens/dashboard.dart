import 'package:eco_waste/controller/auth_controller.dart';
import 'package:eco_waste/screens/homepage.dart';
import 'package:eco_waste/screens/blog.dart';
import 'package:eco_waste/screens/settings.dart';
import 'package:eco_waste/screens/trash_centres.dart';
import 'package:eco_waste/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int currentIndex = 0;
  List<Widget> screens = [
    const HomePage(),
    const TrashCentres(),
    const Blog(),
    const Settings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      // ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: AppColor.primary,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (value) => setState(() {
          currentIndex = value;
        }),
        selectedIconTheme: IconThemeData(color: AppColor.primary),
        unselectedIconTheme: IconThemeData(color: AppColor.txtBlack),
        selectedLabelStyle: TextStyle(color: AppColor.primary),
        unselectedLabelStyle: TextStyle(color: AppColor.txtBlack),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), label: 'Trash Centres'),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined), label: 'Blog'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
