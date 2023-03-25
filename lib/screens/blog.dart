import 'dart:io';

import 'package:eco_waste/services/api.dart';
import 'package:eco_waste/services/models/waste_model.dart';
import 'package:eco_waste/utils/colors.dart';
import 'package:eco_waste/utils/widget/shimmer.dart';

import 'package:eco_waste/utils/widget/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

class Blog extends StatefulWidget {
  Blog({super.key});

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  Future<WasteModel>? _wasteNews;
  @override
  void initState() {
    super.initState();
    _wasteNews = ApiCall().wasteApi();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(
              height: 16,
            ),
            Text(
              'Blog',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Why disposing of trash is essential',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 16,
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<WasteModel>(
          future: _wasteNews,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center();
              case ConnectionState.waiting:
                //return CustomShimmer();
                return  Center(
                  child: SpinKitThreeBounce(
                                              color: AppColor.primary,
                                              size: 16,
                                            ),
                );
              case ConnectionState.active:
                return const Center();
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Unable to get Waste News. Kindly Refresh',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w500),
                    ),
                  );
                } else if (snapshot.hasData) {
                  if (snapshot.data!.articles == null ||
                      snapshot.data!.articles!.isEmpty) {
                    return const Center(
                      child: Text('Oops! No article found 🥴'),
                    );
                  } else {
                    return BlogCard(data: snapshot.data!);
                  }
                } else {
                  return const Text('No Internet Connection');
                }
            }
          },
        ),
      ),
    );
  }
}

  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: const [
  //           Text(
  //             'Blog',
  //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
  //           ),
  //           Text('Why disposing of trash is essential'),
  //         ],
  //       ),
  //     ),
  //     body: SafeArea(
  //         child: Padding(
  //       padding: const EdgeInsets.only(left: 18.0, right: 18.0),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           SizedBox(
  //             width: width,
  //             height: 230,
  //             child: ListView.builder(
  //               shrinkWrap: true,
  //               itemCount: 2,
  //               scrollDirection: Axis.horizontal,
  //               itemBuilder: (context, index) {
  //                 return Row(
  //                   children: [
  //                     BlogCard(
  //                         title: 'Waste Sorting tips',
  //                         subtitle: 'Damilola',
  //                         buttontext: 'Turn On Location',
  //                         color: AppColor.primary,
  //                         txtColor: Colors.white,
  //                         buttoncolor: AppColor.primary),
  //                     BlogCard(
  //                         color: AppColor.mintgreen,
  //                         title: 'Environmental tips',
  //                         subtitle: 'Damilola',
  //                         buttontext: 'Notify us',
  //                         txtColor: AppColor.primary,
  //                         buttoncolor: Colors.white),
  //                   ],
  //                 );
  //               },
  //             ),
  //           ),
  //           SizedBox(
  //             height: 25,
  //           ),
  //           Text(
  //             'Awareness',
  //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
  //           ),
  //           Expanded(
  //             child: ListView.builder(
  //               shrinkWrap: true,
  //               itemCount: 6,
  //               scrollDirection: Axis.vertical,
  //               itemBuilder: (context, index) {
  //                 return const AwarenessItems();
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     )),
  //   );
  // }

