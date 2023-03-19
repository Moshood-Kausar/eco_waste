import 'package:eco_waste/controller/auth_controller.dart';
import 'package:eco_waste/screens/homepage.dart';
import 'package:eco_waste/screens/blog.dart';
import 'package:eco_waste/screens/settings.dart';
import 'package:eco_waste/screens/trash_centres.dart';
import 'package:eco_waste/services/api.dart';
import 'package:eco_waste/services/models/nearby_model.dart';
import 'package:eco_waste/utils/colors.dart';
import 'package:eco_waste/utils/widget/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<NearByModel> nearbyLocations = [];
  int currentIndex = 0;
  final List<Widget> screens = [
    const HomePage(),
    const Blog(),
    const Settings()
  ];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    //isLoading = false;
    ApiCall.getnearbyPlace('7.3218181 3.8472435').then((value) {
      setState(() {
        screens.insert(
          1,
          TrashCentres(data: value),
        );
        loading = false;
      });
    });}

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        // ),
        body: loading ? const CustomShimmer() : screens[currentIndex],
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

