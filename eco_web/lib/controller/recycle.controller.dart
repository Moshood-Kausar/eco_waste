import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RecycleController extends GetxController {
  var currentEdit = ''.obs;
  Future updatePickup(var index) async {
    try {
      await FirebaseFirestore.instance
          .collection('user_recycle')
          .get()
          .then(
            (QuerySnapshot snapshot) async => {
              currentEdit(snapshot.docs[index].reference.id),
            },
          )
          .then(
            (value) => {
              FirebaseFirestore.instance
                  .collection('user_recycle')
                  .doc(currentEdit.value)
                  .update(
                {'isPickedUp': true},
              )
            },
          );
    } catch (e) {
      log(e.toString());
    }
  }
}
