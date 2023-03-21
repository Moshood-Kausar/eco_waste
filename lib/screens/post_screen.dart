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
  final HomeController _homeConntroller = Get.find();
  final AuthController _authController = Get.find();
  final _formKey = GlobalKey<FormState>();
  int? selectedIndex;
  final TextEditingController _address = TextEditingController();

  bool btnLoad = false;
  String? _currentAddress;
  Position? _currentPosition;
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 200,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        // image: DecorationImage(
                        //   fit: BoxFit.cover,
                        //   colorFilter: ColorFilter.mode(
                        //     Colors.white.withOpacity(0.2),
                        //     BlendMode.modulate,
                        //   ),
                        // ),
                      ),
                      child: Obx(
                        () => _homeConntroller.filePath.toString().isEmpty
                            ? Image.asset(
                                'assets/images/trash1.jpg',
                              )
                            : Image.file(
                                File(_homeConntroller.filePath.toString()),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        // _homeConntroller.selectFile();
                        _homeConntroller.captureImage();
                      },
                      icon: Icon(
                        Icons.camera_enhance,
                        color: AppColor.primary,
                        size: 40,
                      ),
                    ),
                  ],
                ),
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
                            onTap: _getCurrentPosition,
                            child: Container(
                              color: AppColor.primary,
                              height: 40,
                              width: 40,
                              child: const Padding(
                                padding: EdgeInsets.all(1.0),
                                child: Text(
                                  'Tap to \n Locate',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                  textAlign: TextAlign.center,
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
                              text: _currentAddress ?? "",
                            ),
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
                              ),
                            )
                          : AppButton(
                              onPressed: () async {
                                DumpPost post = DumpPost(
                                  userId:
                                      _authController.firebaseUser.value!.uid,
                                  imageUrl: '',
                                  landmark: _address.text.trim().toString(),
                                  location: _currentAddress.toString(),
                                  coordinate:
                                      '${_currentPosition!.latitude} ${_currentPosition!.longitude} ',
                                  createdAt: DateTime.now().toString(),
                                );
                                await _homeConntroller.uploadImage(post);
                              },
                              text: 'Make a new Post'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
