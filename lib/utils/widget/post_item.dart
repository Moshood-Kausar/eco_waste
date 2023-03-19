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
      padding: const EdgeInsets.only(bottom: 16.0),
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
                  height: 80,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          landmark,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 8,),
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
        ],
      ),
    );
  }
}
