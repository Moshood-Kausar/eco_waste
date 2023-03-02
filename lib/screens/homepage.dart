import 'package:eco_waste/utils/colors.dart';
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
        centerTitle: false,
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
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   'Hi Kausar!',
                //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                // ),
                // Text('Let\'s clean our community.'),
                // SizedBox(height: 15),
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
                              card(
                                  title: 'Request Pick Up',
                                  subtitle: 'Let\'s make the environment clean',
                                  buttontext: 'Turn On Location',
                                  color: AppColor.primary,
                                  txtColor: Colors.white,
                                  buttoncolor: AppColor.primary),
                              card(
                                  color: AppColor.mintgreen,
                                  title: 'Let us know about Waste Around you',
                                  subtitle: 'Get in touch with us',
                                  buttontext: 'Notify us',
                                  txtColor: AppColor.primary,
                                  buttoncolor: Colors.white),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Posts',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Expanded(
                        child: posts(),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget card(
      {String? title,
      subtitle,
      buttontext,
      buttoncolor,
      txtColor,
      pic,
      Color? color}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width - 100,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$title',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: txtColor),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '$subtitle',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                      color: txtColor),
                ),
                SizedBox(
                  height: 5,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: () {},
                  child: Text(
                    '$buttontext',
                    style: TextStyle(color: buttoncolor),
                  ),
                  color: txtColor,
                )
              ],
            ),
          )),

      // body: Padding(
      //   padding: const EdgeInsets.only(left: 18.0, right: 18),
      //   child: SingleChildScrollView(
      //     child: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         // Text(
      //         //   'Hi Kausar!',
      //         //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
      //         // ),
      //         // Text('Let\'s clean our community.'),
      //         // SizedBox(height: 15),
      //         Column(
      //           children: [
      //             Container(
      //               height: 200,
      //               width: MediaQuery.of(context).size.width,
      //               decoration: BoxDecoration(
      //                   color: AppColor.primary,
      //                   borderRadius: BorderRadius.circular(8)),
      //               child: Padding(
      //                 padding: const EdgeInsets.all(10.0),
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text(
      //                       'Request Pick Up',
      //                       style: TextStyle(
      //                           fontSize: 16,
      //                           fontWeight: FontWeight.w600,
      //                           color: Colors.white),
      //                     ),
      //                     SizedBox(
      //                       height: 5,
      //                     ),
      //                     Text(
      //                       'Let\'s make the environment clean',
      //                       style: TextStyle(
      //                           fontSize: 12,
      //                           fontWeight: FontWeight.w200,
      //                           color: Colors.white),
      //                     ),
      //                     SizedBox(
      //                       height: 5,
      //                     ),
      //                     MaterialButton(
      //                       shape: RoundedRectangleBorder(
      //                           borderRadius: BorderRadius.circular(8)),
      //                       onPressed: () {
      //                         _authController.signOut();
      //                       },
      //                       child: Text('Turn On Location'),
      //                       color: Colors.white,
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             ),
      //             SizedBox(
      //               height: 20,
      //             ),
      //             Container(
      //               height: 200,
      //               width: MediaQuery.of(context).size.width,
      //               decoration: BoxDecoration(
      //                   color: AppColor.mintgreen,
      //                   borderRadius: BorderRadius.circular(8)),
      //               child: Padding(
      //                 padding: const EdgeInsets.all(10.0),
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text(
      //                       'Let us know about Waste Around you',
      //                       style: TextStyle(
      //                           fontSize: 16,
      //                           fontWeight: FontWeight.w600,
      //                           color: AppColor.primary),
      //                     ),
      //                     SizedBox(
      //                       height: 5,
      //                     ),
      //                     Text(
      //                       'Get in touch with us',
      //                       style: TextStyle(
      //                           fontSize: 12,
      //                           fontWeight: FontWeight.w200,
      //                           color: AppColor.primary),
      //                     ),
      //                     SizedBox(
      //                       height: 5,
      //                     ),
      //                     MaterialButton(
      //                       shape: RoundedRectangleBorder(
      //                           borderRadius: BorderRadius.circular(8)),
      //                       onPressed: () {},
      //                       child: Text(
      //                         'Notify us',
      //                         style: TextStyle(color: Colors.white),
      //                       ),
      //                       color: AppColor.primary,
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             ),
      //             SizedBox(
      //               height: 30,
      //             ),
      //             Align(
      //               alignment: Alignment.topLeft,
      //               child: Text(
      //                 'Posts',
      //                 style:
      //                     TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
      //               ),
      //             ),
      //             // Expanded(

      //             //   flex: 1,
      //             //   child: card()),
      //           ],
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

// Widget posts({String? title, subtitle, pic}) {
//   return ListView.builder(
//       shrinkWrap: true,
//       itemCount: 26,

Widget posts({String? title, subtitle, pic}) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: 6,

      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.08),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: const Color(0xffe5e5e5).withOpacity(0.25),
                  //     blurRadius: 14,
                  //     offset: const Offset(0, 11),
                  //   )
                  // ],
                ),
                child: ListTile(
                  leading: Image.asset('assets/images/boardone.png'),
                  title: Text(
                    'A Dump Site',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColor.primary,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('MayFair Junction')
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
