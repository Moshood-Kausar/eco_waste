import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_web/controller/auth_controller.dart';
import 'package:eco_web/controller/recycle.controller.dart';
import 'package:eco_web/controller/waste_controller.dart';
import 'package:eco_web/utils/widget/recycle_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecycleItems extends StatefulWidget {
  const RecycleItems({super.key});

  @override
  State<RecycleItems> createState() => _RecycleItemsState();
}

class _RecycleItemsState extends State<RecycleItems> {
  final RecycleController recycleController = Get.find();
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
      if (constraints.maxWidth <= 800) {
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('recycle')
              .doc(authController.firebaseUser.value!.uid)
              .collection('list')
              .orderBy("created_at", descending: true)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                    // color: AppColor.primary,
                    // size: 16,
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
                      return RecycleCard(
                        date: snapshot.data!.docs[index]['created_at'],
                        isPicked: snapshot.data!.docs[index]['isPickedUp'],
                        qty: snapshot.data!.docs[index]['qty'],
                        type: snapshot.data!.docs[index]['item'],
                        index: index,
                        recycleController: recycleController,
                      );
                    },
                  ),
                );
              case ConnectionState.done:
                return const Text('ConnectionState.done');
            }
          },
        );
      } else {
        return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('user_recycle')
                .orderBy("created_at", descending: true)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                      // color: AppColor.primary,
                      // size: 16,
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
                    child: GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 3,
                              crossAxisCount: 2,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 0),
                      itemBuilder: (BuildContext context, int index) {
                        return RecycleCard(
                          date: snapshot.data!.docs[index]['created_at'],
                          isPicked: snapshot.data!.docs[index]['isPickedUp'],
                          qty: snapshot.data!.docs[index]['qty'],
                          type: snapshot.data!.docs[index]['item'],
                          index: index,
                          recycleController: recycleController,
                        );
                      },
                    ),
                  );
                case ConnectionState.done:
                  return const Text('ConnectionState.done');
              }
            });
      }
    });
  }
}
