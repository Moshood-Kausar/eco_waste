import 'dart:developer';

import 'package:eco_waste/utils/colors.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({
    required this.imageUrl,
    required this.landmark,
    required this.location,
    required this.date,
    required this.coordinate,
    super.key,
  });

  final String imageUrl, landmark, location, date, coordinate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String s = coordinate;
        int idx = s.indexOf(" ");
        List parts = [s.substring(0, idx).trim(), s.substring(idx + 1).trim()];
        // await MapsLauncher.launchCoordinates(parts[0], parts[1]);
        bool? isMap = await MapLauncher.isMapAvailable(MapType.google);
        if (isMap != null && isMap == true) {
          await MapLauncher.showMarker(
            mapType: MapType.google,
            coords: Coords(double.parse(parts[0]), double.parse(parts[1])),
            title: landmark,
            description: location,
          );
        } else {
          log('No map installed');
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: const Color(0xFF9E9E9E).withOpacity(0.08),
          ),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 110,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: FancyShimmerImage(
                  imageUrl: imageUrl,
                  boxFit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        landmark,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text(
                              location,
                              maxLines: 3,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.location_on,
                              color: AppColor.primary,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        DateFormat('yyyy-MM-dd – kk:mm')
                            .format(DateTime.parse(date)),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
