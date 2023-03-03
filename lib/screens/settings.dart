import 'package:eco_waste/screens/auth/signup.dart';
import 'package:eco_waste/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/auth_controller.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthController _authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            Text('Manage  your account'),
          ],
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
                leading: CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColor.mintgreen,
                    child: Icon(
                      Icons.person,
                      size: 18,
                      color: AppColor.primary,
                    )),
                title: Text(
                  'Profile',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 18,
                  color: AppColor.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColor.mintgreen,
                    child: Icon(
                      Icons.lock,
                      size: 18,
                      color: AppColor.primary,
                    )),
                title: Text(
                  'Reset Password',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 18,
                  color: AppColor.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColor.mintgreen,
                    child: Icon(
                      Icons.call,
                      size: 18,
                      color: AppColor.primary,
                    )),
                title: Text(
                  'Help and Complaints',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 18,
                  color: AppColor.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColor.mintgreen,
                    child: Icon(
                      Icons.message,
                      size: 18,
                      color: AppColor.primary,
                    )),
                title: Text(
                  'FAQs',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 18,
                  color: AppColor.black,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ListTile(
                enabled: true,
                selected: true,
                selectedTileColor: const Color(0xffffF1F1),
                title: const Text(
                  'Log Out',
                  style: TextStyle(
                    color: Color(0xffDA1E28),
                  ),
                ),
                trailing: const Icon(
                  Icons.logout,
                  color: Color(0xffDA1E28),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text(
                          'Are you sure you want to Log out?',
                          style: TextStyle(fontSize: 12),
                        ),
                        backgroundColor: const Color(0xffEDF5FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('No',
                                style: TextStyle(
                                  color: AppColor.primary,
                                )),
                          ),
                          TextButton(
                            onPressed: () async {
                              await _authController.signOut();
                            },
                            child: const Text(
                              'Yes',
                              style: TextStyle(
                                color: Color(0xffDA1E28),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
