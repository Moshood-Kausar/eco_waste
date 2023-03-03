import 'package:eco_waste/utils/colors.dart';
import 'package:eco_waste/utils/widget/home_card.dart';
import 'package:eco_waste/utils/widget/post_item.dart';
import 'package:flutter/material.dart';
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
            const Text('Let\'s clean our community.'),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: width,
                    height: 200,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            HomeCard(
                              color: AppColor.primary,
                              title: 'Let us know about Waste Around you',
                              subtitle: 'Get in touch with us',
                              buttontext: 'New Post',
                              txtColor: Colors.white,
                              buttoncolor: AppColor.primary,
                              pic: '',
                            ),
                            HomeCard(
                              title: 'Request Pick Up',
                              subtitle: 'Let\'s make the environment clean',
                              buttontext: 'Turn On Location',
                              color: AppColor.mintgreen,
                              txtColor: AppColor.primary,
                              buttoncolor: Colors.white,
                              pic: '',
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Posts',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return const PostListItem();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
