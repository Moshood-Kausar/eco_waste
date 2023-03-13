import 'dart:io';

import 'package:eco_waste/services/api.dart';
import 'package:eco_waste/services/models/waste_model.dart';
import 'package:eco_waste/utils/colors.dart';
import 'package:eco_waste/utils/widget/learn_widget.dart';
import 'package:eco_waste/utils/widget/waste_news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Learn extends StatefulWidget {
  const Learn({super.key});

  @override
  State<Learn> createState() => _LearnState();
}

class _LearnState extends State<Learn> {
  
 

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
            Text(
              'Learn',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            Text('Why disposing of trash is essential'),
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
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
                return const Center();
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Unable to get Waste News. Kindly Refresh',
                      style:
                          TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                    ),
                  );
                } else if (snapshot.hasData) {
                  if (snapshot.data!.articles == null ||
                      snapshot.data!.articles!.isEmpty) {
                    return const Center(
                      child: Text('Oops! No article found 🥴'),
                    );
                  } else {
                    return WasteNewsCard(data: snapshot.data!);
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
  //             'Learn',
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
  //                     LearnCard(
  //                         title: 'Waste Sorting tips',
  //                         subtitle: 'Damilola',
  //                         buttontext: 'Turn On Location',
  //                         color: AppColor.primary,
  //                         txtColor: Colors.white,
  //                         buttoncolor: AppColor.primary),
  //                     LearnCard(
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

