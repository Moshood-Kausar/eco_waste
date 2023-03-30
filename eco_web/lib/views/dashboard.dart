import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:eco_web/controller/auth_controller.dart';
import 'package:eco_web/views/recycle_items.dart';
import 'package:eco_web/views/waste_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/color.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late List<CollapsibleItem> _items;
  int currentIndex = 0;
  final List<Widget> screens = [const RecycleItems(), const WasteItems()];
  @override
  void initState() {
    super.initState();
    _items = _generateItems;
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'Recycling Items',
        icon: Icons.recycling_sharp,
        onPressed: () {
          setState(() {
            currentIndex = 0;
          });
        },
        isSelected: true,
      ),
      CollapsibleItem(
          text: 'Waste Items',
          icon: Icons.restore_from_trash,
          onPressed: () {
            setState(() {
              currentIndex = 1;
            });
          }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final AuthController _authController = Get.find();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: WebColor.primary,
        title: const Text('Let\'s get to know about waste around us'),
      ),
      body: SafeArea(
        child: Obx(
          () => CollapsibleSidebar(
            isCollapsed: MediaQuery.of(context).size.width <= 1200,
            items: _items,
            borderRadius: 0,
            collapseOnBodyTap: false,
            title:
                'Hello ${_authController.firestoreUser.value == null ? '' : _authController.firestoreUser.value!.fullName}!',
            body: screens[currentIndex],
            selectedIconBox: Colors.black,
            unselectedTextColor: Colors.black,
            backgroundColor: WebColor.maingrey,
            selectedTextColor: Colors.white,
            selectedIconColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 15,
            ),
            iconSize: 18,
            itemPadding: 20,
            titleStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            toggleTitleStyle:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            sidebarBoxShadow: const [],
          ),
        ),
      ),
    );
  }
}
