import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:eco_waste/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

class TrashCentres extends StatefulWidget {
  final dynamic data;
  TrashCentres({Key? key, this.data}) : super(key: key);

  @override
  State<TrashCentres> createState() => _TrashCentresState();
}

class _TrashCentresState extends State<TrashCentres> {
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
            return GestureDetector(
              onTap: () async {
                bool? isMap = await MapLauncher.isMapAvailable(MapType.google);
                if (isMap != null && isMap == true) {
                  await MapLauncher.showMarker(
                    mapType: MapType.google,
                    coords: Coords(
                      double.parse(
                          '${widget.data[index].geometry!.location!.lat}'),
                      double.parse(
                          '${widget.data[index].geometry!.location!.lng}'),
                    ),
                    title: '${widget.data[index].name}',
                    description: '${widget.data[index].vicinity}',
                  );
                } else {
                  log('No map installed');
                }
              },
              child: Card(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  NetworkImage('${widget.data[index].icon}'))),
                    ),
                    ListTile(
                      minVerticalPadding: 10,
                      title: Text(
                        '${widget.data[index].name}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
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
                        ],
                      ),
                      leading: Text(widget.data[index].openingHours!.openNow),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
