import 'package:eco_waste/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({
    required this.imageUrl,
    required this.landmark,
    required this.location,
    required this.date,
    super.key,
  });

  final String imageUrl, landmark, location, date;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: const Color(0xFF9E9E9E).withOpacity(0.08),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  height: 60,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        landmark,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppColor.primary,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Text(
                            location,
                            maxLines: 1,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        DateFormat('yyyy-MM-dd – kk:mm')
                            .format(DateTime.parse(date)),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
