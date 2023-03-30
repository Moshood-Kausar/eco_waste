import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class WasteController extends GetxController {
  var currentEdit = ''.obs;
  @override
  void onInit() {
    // updatePickup();
    super.onInit();
  }

  Future updatePickup(var index) async {
    try {
      await FirebaseFirestore.instance
          .collection('dumps')
          .get()
          .then(
            (QuerySnapshot snapshot) async => {
              currentEdit(snapshot.docs[index].reference.id),
              // log(
              //   snapshot.docs[0].reference.id,
              // ),
            },
          )
          .then(
            (value) => {
              FirebaseFirestore.instance
                  .collection('dumps')
                  .doc(currentEdit.value)
                  .update(
                {'isPicked': true},
              )
            },
          );
    } catch (e) {
      log(e.toString());
    }
  }
}
