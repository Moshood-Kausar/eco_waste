import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_web/controller/waste_controller.dart';
import 'package:eco_web/utils/widget/waste_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WasteItems extends StatefulWidget {
  const WasteItems({super.key});

  @override
  State<WasteItems> createState() => _WasteItemsState();
}

class _WasteItemsState extends State<WasteItems> {
  @override
  Widget build(BuildContext context) {
    final WasteController wasteController = Get.find();
    return LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
      if (constraints.maxWidth <= 800) {
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('dumps')
              .orderBy("created_at", descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      return WasteCard(
                        image:
                            snapshot.data!.docs[index]['imageUrl'].toString(),
                        landmark:
                            snapshot.data!.docs[index]['landmark'].toString(),
                        location:
                            snapshot.data!.docs[index]['location'].toString(),
                        date:
                            snapshot.data!.docs[index]['created_at'].toString(),
                        coordinate: snapshot.data!.docs[index]['coordinate'],
                        isPicked: snapshot.data!.docs[index]['isPicked'],
                        id: index,
                        wasteController: wasteController,
                      );
                    },
                  ),
                );
              case ConnectionState.done:
                return const Text('ConnectionState.done');
            }
          },
        );
      }
      if (constraints.maxWidth <= 1200) {
        return StreamBuilder<Object>(
          stream: FirebaseFirestore.instance
              .collection('dumps')
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
                return GridView.builder(
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 3,
                            crossAxisCount: 2,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 0),
                    itemBuilder: (BuildContext context, int index) {
                      return WasteCard(
                        image:
                            snapshot.data!.docs[index]['imageUrl'].toString(),
                        landmark:
                            snapshot.data!.docs[index]['landmark'].toString(),
                        location:
                            snapshot.data!.docs[index]['location'].toString(),
                        date:
                            snapshot.data!.docs[index]['created_at'].toString(),
                        coordinate: snapshot.data!.docs[index]['coordinate'],
                        isPicked: snapshot.data!.docs[index]['isPicked'],
                        id: index,
                        wasteController: wasteController,
                      );
                    });
              case ConnectionState.done:
                return const Text('ConnectionState.done');
            }
          },
        );
      }
      return StreamBuilder<Object>(
        stream: FirebaseFirestore.instance
            .collection('dumps')
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
              return GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3,
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 0),
                  itemBuilder: (BuildContext context, int index) {
                    return WasteCard(
                      image: snapshot.data!.docs[index]['imageUrl'].toString(),
                      landmark:
                          snapshot.data!.docs[index]['landmark'].toString(),
                      location:
                          snapshot.data!.docs[index]['location'].toString(),
                      date: snapshot.data!.docs[index]['created_at'].toString(),
                      coordinate: snapshot.data!.docs[index]['coordinate'],
                      isPicked: snapshot.data!.docs[index]['isPicked'],
                      id: index, wasteController: wasteController,

                      // image: image,
                      // date: date,
                      // isPicked: isPicked,
                      // landmark: landmark,
                      // location: location,
                    );
                  });
            case ConnectionState.done:
              return const Text('ConnectionState.done');
          }
        },
      );
    });
  }
}
