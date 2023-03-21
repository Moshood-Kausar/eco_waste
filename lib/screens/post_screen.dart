import 'dart:io';

import 'package:eco_waste/controller/auth_controller.dart';
import 'package:eco_waste/data/dump_model.dart';
import 'package:eco_waste/utils/appbuttons.dart';
import 'package:eco_waste/utils/colors.dart';
import 'package:eco_waste/utils/text_form.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final HomeController _homeController = Get.find();
  final AuthController _authController = Get.find();
  final _formKey = GlobalKey<FormState>();
  int? selectedIndex;
  final TextEditingController _address = TextEditingController();

  bool btnLoad = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'New Post',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            Text('Let\'s us know about waste around you'),
          ],
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: _homeController.filePath.toString().isEmpty
                          ? Image.asset(
                              'assets/images/trash1.jpg',
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(_homeController.filePath.toString()),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageSelector(
                      action: () => _homeController.captureImage(),
                      icon: Icons.camera_alt,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    ImageSelector(
                      action: () => _homeController.selectFile(),
                      icon: Icons.image,
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      const Text('Upload Picture of Waste'),
                      const SizedBox(
                        height: 50,
                      ),
                      AppTextFormField(
                        maxLength: 20,
                        controller: _address,
                        text: 'Nearest Address',
                        hintText: 'Oduduwa City',
                        icon: const Icon(Icons.location_city_sharp,
                            color: Colors.grey),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Empty field detected';
                          } else if (value.length < 2) {
                            return 'Nearest Address cannot be less than 3 characters';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  btnLoad = true;
                                });
                                _homeController.getCurrentPosition(context);
                                setState(() {
                                  btnLoad = false;
                                });
                              },
                              child: Container(
                                color: AppColor.primary,
                                height: 40,
                                width: 40,
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: !btnLoad
                                      ? const Text(
                                          'Tap to \n Locate',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                          textAlign: TextAlign.center,
                                        )
                                      : const Center(
                                          child: SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2.2,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          )),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 4,
                            child: AppTextFormField(
                              controller: TextEditingController(
                                  text: _homeController.currentAddress
                                      .toString()),
                              enable: false,
                              text: 'Location on maps',
                              hintText: 'map location address',
                              icon: const Icon(Icons.location_on_outlined,
                                  color: Colors.grey),
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Empty field detected';
                                } else if (value.length < 2) {
                                  return 'Nearest Address cannot be less than 3 characters';
                                } else {
                                  return null;
                                }
                              },
                           
                            enable: false,
                            text: '',
                            hintText: 'map location address',
                            icon: const Icon(Icons.location_on_outlined,
                                color: Colors.grey),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Empty field detected';
                              } else if (value.length < 2) {
                                return 'Nearest Address cannot be less than 3 characters';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Tap the button to automatically generate your location',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color(
                          0xff525252,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const SizedBox(height: 100),
                    Obx(
                      () => _homeConntroller.isLoading.value
                          ? const Center(
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.2,

                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Obx(
                        () => _homeController.isLoading.value
                            ? const Center(
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.2,
                                  ),

                                ),
                              )
                            : AppButton(
                                onPressed: () async {
                                  DumpPost post = DumpPost(
                                    userId:
                                        _authController.firebaseUser.value!.uid,
                                    imageUrl: '',
                                    landmark: _address.text.trim().toString(),
                                    location: _homeController.currentAddress
                                        .toString(),
                                    coordinate:
                                        _homeController.coordinate.toString(),
                                    createdAt: DateTime.now().toString(),
                                  );
                                  await _homeController.uploadImage(post);
                                },
                                text: 'Make a new Post'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class ImageSelector extends StatelessWidget {
  const ImageSelector({
    super.key,
    required this.action,
    required this.icon,
  });

  final Function()? action;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.all(Radius.circular(100))),
        child: Icon(
          icon,
          color: AppColor.primary,
          size: 24,
        ),
      ),
    );
  }
}
