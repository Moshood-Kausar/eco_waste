// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_waste/screens/dashboard.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../data/dump_model.dart';

class HomeController extends GetxController {
  var fileExtension = ''.obs;
  var filePath = ''.obs;
  var fileExt = ''.obs;
  var imageUrl = ''.obs;
  var isLoading = false.obs;

  var currentAddress = ''.obs;
  var coordinate = ''.obs;

  Position? _currentPosition;

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void onInit() {}

  Future<void> captureImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    filePath(file!.path);
  }

  Future<void> uploadImage(DumpPost post) async {
    isLoading(true);
    Reference refRoot = FirebaseStorage.instance.ref().child('dumps_images');
    Reference ref = refRoot.child('${DateTime.now().millisecondsSinceEpoch}');
    try {
      await ref.putFile(File(filePath.value.toString()));

      var url = await ref.getDownloadURL();
      imageUrl(url);
      await makePost(post);
      isLoading(false);
      filePath('');
      Get.back();
    } catch (error) {
      isLoading(false);
      log(error.toString());
    }
  }

  Future<void> makePost(DumpPost post) async {
    FirebaseFirestore.instance.collection('dumps').add({
      "userID": post.userId,
      "imageUrl": imageUrl.value,
      "landmark": post.landmark,
      "location": post.location,
      "coordinate": post.coordinate,
      "created_at": post.createdAt,
      "isPicked": false,
    });
  }

  Future<dynamic> selectFile() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    filePath(file!.path);
  }

  Future<void> getCurrentPosition(BuildContext context) async {
    final hasPermission = await _handleLocationPermission(context);

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _getAddressFromLatLng(position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> _handleLocationPermission(BuildContext context) async {
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

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress(
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}');
      coordinate('${position.latitude} ${position.longitude}');
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
