import 'package:auto_size_text/auto_size_text.dart';
import 'package:eco_waste/utils/colors.dart';
import 'package:eco_waste/utils/widget/trash_center_list_item.dart';
import 'package:flutter/material.dart';

class TrashCentres extends StatefulWidget {
  const TrashCentres({super.key});

  @override
  State<TrashCentres> createState() => _TrashCentresState();
}

class _TrashCentresState extends State<TrashCentres> {
  final TextEditingController _searchController = TextEditingController();
  String strValue = '';

  bool _startloading = false;
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
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 90,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextFormField(
              controller: _searchController,
              cursorColor: const Color(0xff525252),
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                fillColor: const Color(0xffF4F4F4),
                filled: true,
                isDense: true,
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                contentPadding:
                    const EdgeInsets.only(left: 10.0, right: 0.0, top: 12),
                hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColor.primary)),
                hintText: 'Search for the nearest trash centre',
              ),
              onChanged: (value) {
                strValue = value;
                setState(() {});
              },
              // textCapitalization: TextCapitalization.characters,
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 6,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return const TrashCenterItem();
                  }),
            ),
          ],
        ),
      )),
    );
  }
}
