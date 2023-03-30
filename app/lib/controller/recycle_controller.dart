import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_waste/controller/auth_controller.dart';
import 'package:eco_waste/data/recycled.dart';
import 'package:get/get.dart';

class RecycleController extends GetxController {
  var noPlastics = '0'.obs;
  var noCardboard = '0'.obs;
  var noElectronics = '0'.obs;
  var noGlass = '0'.obs;
  var isLoading = false.obs;
  // Rxn<RRecord> record = Rxn<RRecord>();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final AuthController _authController = Get.find();

  @override
  void onInit() async {
    // record.bindStream(records());
    // log(record.value!.noCardboard.toString());
    await records();
    super.onInit();
  }

  Future records() async {
    var result = _db
        .collection('recycle')
        .doc(_authController.firebaseUser.value!.uid)
        .get()
        .then(
      (value) async {
        if (!value.exists) {
          await FirebaseFirestore.instance
              .collection('recycle')
              .doc(_authController.firebaseUser.value!.uid)
              .set(
            {
              'noPlastics': 0,
              'noCardboard': 0,
              'noElectronics': 0,
              'noGlass': 0,
            },
          );
        } else {
          noCardboard(value.data()!['noCardboard'].toString());
          noElectronics(value.data()!['noElectronics'].toString());
          noGlass(value.data()!['noGlass'].toString());
          noPlastics(value.data()!['noPlastics'].toString());
        }
      },
    );
  }

  Future postRecycle(Recycled post) async {
    try {
      isLoading(true);
      await FirebaseFirestore.instance
          .collection('user_recycle')
          .add(
            {
              "userID": _authController.firebaseUser.value!.uid,
              "item": post.item,
              "qty": post.qty,
              "isPickedUp": post.isPickedUp,
              "created_at": post.createdAt
            },
          )
          .then((value) async => {
                if (post.item == 'Plastic')
                  {
                    await FirebaseFirestore.instance
                        .collection('recycle')
                        .doc(_authController.firebaseUser.value!.uid)
                        .update(
                      {
                        'noPlastics':
                            int.parse(noPlastics.value) + int.parse(post.qty)
                      },
                    )
                  }
                else if (post.item == 'Cardboard')
                  {
                    await FirebaseFirestore.instance
                        .collection('recycle')
                        .doc(_authController.firebaseUser.value!.uid)
                        .update(
                      {
                        'noCardboard':
                            int.parse(noCardboard.value) + int.parse(post.qty)
                      },
                    )
                  }
                else if (post.item == 'Glass')
                  {
                    await FirebaseFirestore.instance
                        .collection('recycle')
                        .doc(_authController.firebaseUser.value!.uid)
                        .update(
                      {
                        'noGlass':
                            int.parse(noGlass.value) + int.parse(post.qty)
                      },
                    )
                  }
                else if (post.item == 'Electronics')
                  {
                    await FirebaseFirestore.instance
                        .collection('recycle')
                        .doc(_authController.firebaseUser.value!.uid)
                        .update(
                      {
                        'noElectronics':
                            int.parse(noElectronics.value) + int.parse(post.qty)
                      },
                    )
                  },
              })
          .then(
            (value) => records(),
          );

      isLoading(false);
      Get.back();
    } catch (e) {
      isLoading(false);
      log(e.toString());
    }
  }
}
