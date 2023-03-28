import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_waste/controller/auth_controller.dart';
import 'package:eco_waste/controller/recycle_controller.dart';
import 'package:eco_waste/data/recycled.dart';
import 'package:eco_waste/screens/recycle/recycle_item.dart';
import 'package:eco_waste/screens/recycle/widget/recycle_list_item.dart';
import 'package:eco_waste/utils/appbuttons.dart';
import 'package:eco_waste/utils/colors.dart';
import 'package:eco_waste/utils/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class RecycleScreen extends StatelessWidget {
  const RecycleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RecycleController recycleController = Get.put(RecycleController());
    final AuthController _authController = Get.find();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Let\'s Recycle',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 13.0,
                    color: Color.fromARGB(13, 0, 0, 0),
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10,
                  ),
                ),
              ),
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Number of Items recycled.'),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          RecycleItems(
                            image: 'assets/images/plastic.png',
                            title: 'Plastics',
                            value: recycleController.noPlastics.value,
                          ),
                          RecycleItems(
                            image: 'assets/images/glass.png',
                            title: 'Glass',
                            value: recycleController.noGlass.value,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          RecycleItems(
                            image: 'assets/images/box.png',
                            title: 'Cardboard',
                            value: recycleController.noCardboard.value,
                          ),
                          RecycleItems(
                            image: 'assets/images/electronics.png',
                            title: 'Electronics',
                            value: recycleController.noElectronics.value,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 16,
            ),
            const Text(
              'Recycling',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('user_recycle')
                  .orderBy("created_at", descending: true)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: SpinKitThreeBounce(
                      color: AppColor.primary,
                      size: 16,
                    ),
                  );
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Text('ConnectionState.waiting');
                  case ConnectionState.none:
                    return const Text('ConnectionState.none');
                  case ConnectionState.active:
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        // scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          if (snapshot.data!.docs[index]['userID'] ==
                              _authController.firebaseUser.value!.uid) {
                            Recycled recycled = Recycled(
                                userId: snapshot.data!.docs[index]['userID'],
                                item: snapshot.data!.docs[index]['item'],
                                qty: snapshot.data!.docs[index]['qty'],
                                isPickedUp: snapshot.data!.docs[index]
                                    ['isPickedUp'],
                                createdAt: snapshot.data!.docs[index]
                                    ['created_at']);

                            return ListItemRecycle(
                              recycled: recycled,
                            );
                          }
                        },
                      ),
                    );
                  case ConnectionState.done:
                    return const Text('ConnectionState.done');
                }
              },
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: 10,
            //     itemBuilder: ((context, index) => const ListItemRecycle(recycled: null,)),
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primary,
        onPressed: () {
          String dropdownvalue = 'Plastic';
          showModalBottomSheet(
            isDismissible: false,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
            ),
            builder: ((context) {
              return const RecycleBottomModal();
            }),
          );
        },
        child: const Icon(
          Icons.recycling,
        ),
      ),
    );
  }
}

class RecycleBottomModal extends StatefulWidget {
  const RecycleBottomModal({super.key});

  @override
  State<RecycleBottomModal> createState() => _RecycleBottomModalState();
}

var items = [
  'Plastic',
  'Cardboard',
  'Electronics',
  'Glass',
];

class _RecycleBottomModalState extends State<RecycleBottomModal> {
  // @override
  // void dispose() {
  //   amount.dispose();
  //   super.dispose();
  // }
  String? dropdownvalue;
  TextEditingController amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final RecycleController recycleController = Get.find();
    return SizedBox(
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Type',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color(0xff525252),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DropdownButton(
                    value: dropdownvalue,
                    hint: const Text('Select item type'),
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(
                        () {
                          dropdownvalue = newValue!;
                        },
                      );
                      // validator: (value)=> value == null ? 'field required' : null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  AppTextFormField(
                    maxLength: 20,
                    controller: amount,
                    text: 'QTY',
                    hintText: '0',
                    keyboardType: TextInputType.number,
                    icon: const Icon(Icons.scale_outlined, color: Colors.grey),
                    // textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Empty field detected';
                      } else if (value.length < 2) {
                        return 'Enter quantity';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Obx(
                    () => recycleController.isLoading.value
                        ? Center(
                            child: SizedBox(
                            height: 30,
                            width: 30,
                            child: SpinKitThreeBounce(
                              color: AppColor.primary,
                              size: 16,
                            ),
                          ))
                        : AppButton(
                            onPressed: () async {
                              String qty = amount.text.toString();

                              if (qty.isNotEmpty && dropdownvalue!.isNotEmpty) {
                                Recycled recycled = Recycled(
                                    userId: '',
                                    item: dropdownvalue.toString(),
                                    qty: qty,
                                    isPickedUp: false,
                                    createdAt: DateTime.now().toString());
                                await recycleController.postRecycle(recycled);
                              } else {
                                Get.snackbar(
                                    'Required field', 'All fields are required',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor:
                                        Get.theme.snackBarTheme.backgroundColor,
                                    colorText: Get
                                        .theme.snackBarTheme.actionTextColor);
                              }
                            },
                            text: 'Recycle'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
