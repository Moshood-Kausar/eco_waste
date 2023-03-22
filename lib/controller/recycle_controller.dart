import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_waste/controller/auth_controller.dart';
import 'package:eco_waste/data/recycled.dart';
import 'package:get/get.dart';

class RecycleController extends GetxController {
  final AuthController _authController = Get.find();
  Future postRecycle(Recycled post) async {
    try {
      await FirebaseFirestore.instance
          .collection(_authController.firebaseUser.value!.uid)
          .doc('')
          .set({
        "userID": _authController.firebaseUser.value!.uid.toString(),
        "item": post.item,
        "qty": post.qty,
        "isPickedUp": post.isPickedUp,
        "created_at": post.createdAt
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
