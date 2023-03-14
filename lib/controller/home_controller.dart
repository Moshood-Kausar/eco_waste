import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_waste/screens/dashboard.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../data/dump_model.dart';

class HomeController extends GetxController {
  var fileExtension = ''.obs;
  var filePath = ''.obs;
  var fileExt = ''.obs;
  var imageUrl = ''.obs;
  var isLoading = false.obs;

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
      log(url);
      imageUrl(url);
      await makePost(post);
      isLoading(false);
      Get.offAll(() => const DashBoard());
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
      "created_at": post.createdAt
    });
  }

  Future<dynamic> selectFile() async {
    var result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: [
      "png",
      'jpeg',
      'jpg',
    ]);
    if (result != null) {
      final file = result.files.first;
      fileExtension(file.extension.toString());
      filePath(file.path.toString());
      return file.path;
    } else {
      log('error occured');
      // toast(
      //     title: 'Media Error',
      //     message:
      //         'An error occurred, select files does not match requirement.');
    }
    return '';
  }
}
