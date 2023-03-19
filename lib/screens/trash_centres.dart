import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:eco_waste/services/api.dart';
import 'package:eco_waste/services/models/nearby_model.dart';
import 'package:eco_waste/utils/colors.dart';
import 'package:eco_waste/utils/widget/trash_center_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrashCentres extends StatefulWidget {
  final dynamic data;
  const TrashCentres({Key? key, this.data}) : super(key: key);

  @override
  State<TrashCentres> createState() => _TrashCentresState();
}

class _TrashCentresState extends State<TrashCentres> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  double lat = 0.0, long = 0.0;

  final TextEditingController _searchController = TextEditingController();
  String strValue = '';

  bool isopen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(
              height: 12,
            ),
            Text(
              'Nearby Trash Centres',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: 3,
            ),
            AutoSizeText(
              'Locate the nearest trash sorting & recycle depot',
              maxLines: 1,
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
        automaticallyImplyLeading: false,
        toolbarHeight: 90,
      ),
      body: ListView.builder(
          itemCount: widget.data.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage('${widget.data[index].icon}'))),
                  ),
                  ListTile(
                    minVerticalPadding: 10,
                    title: Text(
                      '${widget.data[index].name}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.location_on,
                              color: AppColor.grey,
                              size: 16,
                            ),
                          ),
                          Expanded(
                              child: Text('${widget.data[index].vicinity}'))
                        ]),
                  )
                  // Text('${widget.data[index].name}'),
                  // Text('${widget.data[index].businessStatus}'),
                  // Text('${widget.data[index].vicinity}'),
                  // Text('${widget.data[index].rating}'),

                  //Text (' ${widget.data[index].openingHours!.getbool.openNow}'.),
                ],
              ),
            );
          }),
    );
  }
}
//     return Scaffold(
//       appBar: AppBar(
//         // centerTitle: false,
//         // title: Column(
//         //   crossAxisAlignment: CrossAxisAlignment.start,
//         //   children: const [
//         //     SizedBox(
//         //       height: 12,
//         //     ),
//         //     Text(
//         //       'Nearby Trash Centres',
//         //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
//         //     ),
//         //     SizedBox(
//         //       height: 3,
//         //     ),
//         //     AutoSizeText(
//         //       'Locate the nearest trash sorting & recycle depot',
//         //       maxLines: 1,
//         //     ),
//         //   ],
//         // ),
//         automaticallyImplyLeading: false,
//         toolbarHeight: 90,
//       ),
//       body: SingleChildScrollView(
//         // child: SizedBox(
//         //   child: Column(
//         //     children: [
//         //       Padding(
//         //         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         //         child: CupertinoSearchTextField(
//         //           controller: null,
//         //           placeholder: 'Search Google Maps',
//         //           placeholderStyle: TextStyle(color: AppColor.black),
//         //           backgroundColor: Colors.white.withOpacity(0.7),
//         //         ),
//         //       ),
//         //       SizedBox(
//         //         height: 800,
//                 child: Container(
//                   child: ListView.builder(
//                     //scrollDirection: Axis.horizontal,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: widget.data.length,
//                     itemBuilder: (_, index) => Padding(
//                       padding: const EdgeInsets.only(left: 8.0, bottom: 8),
//                       child: Container(
//                         color: Colors.pink,
//                         // width: 200,
//                         child: Card(
//                           elevation: 2,
//                           color: Colors.white,
//                           child: Column(
//                             // crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Expanded(
//                                   child: Container(
//                                 decoration: BoxDecoration(
//                                     borderRadius: const BorderRadius.only(
//                                         topLeft: Radius.circular(4),
//                                         topRight: Radius.circular(4)),
//                                     image: DecorationImage(
//                                         fit: BoxFit.cover,
//                                         image: NetworkImage(
//                                             '${widget.data[index].icon}'))),
//                               )),
//                               Expanded(
//                                 child: Container(
//                                   padding: const EdgeInsets.all(4),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text('${widget.data[index].name}',
//                                           style: const TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w500)),
//                                       const SizedBox(height: 4),
//                                       Row(
//                                         children: [
//                                           // Star(nearbyLocations[index].rating
//                                           //         ?.toInt() ??
//                                           //     0),
//                                           Text(
//                                               ' ${widget.data[index].userRatingsTotal}')
//                                         ],
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Expanded(
//                                         child: Text('${widget.data[index].vicinity}',
//                                             style: const TextStyle(
//                                                 fontSize: 15, color: Colors.grey)),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//       //       ],
//       //     ),
//       //   ),
//       // ),
//     );

//     //  floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
//     // floatingActionButton: FloatingActionButton(
//     //   onPressed: () async {
//     //     final List<NearByModel> result =
//     //         await ApiFunctions.getnearbyPlace('$lat $long').then((value) {
//     //       setState(() {
//     //         nearbyLocations = value;
//     //       });

//     //       return value;
//     //     });
//     //     debugPrint('$result');
//     //   },
//     //   child: const Icon(Icons.near_me),
//     // ),
//     //);
//   }
// }
