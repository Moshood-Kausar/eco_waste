import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_waste/utils/colors.dart';
import 'package:eco_waste/utils/widget/home_card.dart';
import 'package:eco_waste/utils/widget/post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthController _authController = Get.find();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Text(
                'Hi ${_authController.firestoreUser.value == null ? '' : _authController.firestoreUser.value!.fullName}!',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const Text(
              'Let\'s clean our community.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: HomeCard(
                          ontap: () {
                            Navigator.pushNamed(context, '/postscreen');
                          },
                          color: AppColor.maingrey,
                          title: 'Let us know about Waste Around you',
                          subtitle: 'Get in touch with us',
                          buttontext: 'New Post',
                          txtColor: Colors.black,
                          buttoncolor: Colors.white,
                          pic: '',
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: HomeCard(
                          ontap: () {
                            Navigator.pushNamed(context, '/recyclescreen');
                          },
                          title: 'What will you like to Recycle',
                          subtitle: 'Let\'s make the environment clean',
                          buttontext: 'Recycle items',
                          color: AppColor.maingrey,
                          txtColor: Colors.black,
                          buttoncolor: Colors.white,
                          pic: '',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Community Watch',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('dumps')
                    .orderBy("created_at", descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return  Center(
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
                            return PostListItem(
                              imageUrl: snapshot.data!.docs[index]['imageUrl']
                                  .toString(),
                              landmark: snapshot.data!.docs[index]['landmark']
                                  .toString(),
                              location: snapshot.data!.docs[index]['location']
                                  .toString(),
                              date: snapshot.data!.docs[index]['created_at']
                                  .toString(),
                              coordinate: snapshot.data!.docs[index]
                                  ['coordinate'],
                            );
                          },
                        ),
                      );
                    case ConnectionState.done:
                      return const Text('ConnectionState.done');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
