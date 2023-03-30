

// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:eco_waste/services/api.dart';
// import 'package:eco_waste/services/models/nearby_model.dart';
// import 'package:eco_waste/utils/colors.dart';
// import 'package:eco_waste/utils/widget/trash_center_list_item.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class TrashCentres extends StatefulWidget {
//   final dynamic data;
//   const TrashCentres({Key? key, this.data}) : super(key: key);

//   @override
//   State<TrashCentres> createState() => _TrashCentresState();
// }

// class _TrashCentresState extends State<TrashCentres> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: false,
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: const [
//             SizedBox(
//               height: 12,
//             ),
//             Text(
//               'Nearby Trash Centres',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
//             ),
//             SizedBox(
//               height: 3,
//             ),
//             AutoSizeText(
//               'Locate the nearest trash sorting & recycle depot',
//               maxLines: 1,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             SizedBox(
//               height: 16,
//             )
//           ],
//         ),
//         automaticallyImplyLeading: false,
//         toolbarHeight: 90,
//       ),
//       body: TrashCenterItem(),
//     );
//   }
// }
