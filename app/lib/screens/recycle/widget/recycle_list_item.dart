import 'package:eco_waste/data/recycled.dart';
import 'package:eco_waste/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListItemRecycle extends StatelessWidget {
  const ListItemRecycle({
    super.key,
    required this.recycled,
  });

  final Recycled recycled;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColor.maingrey,
                  child: Image.asset(
                    returnImage(recycled.item),
                    height: 24,
                    width: 24,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(recycled.item),
                    const SizedBox(
                      height: 4,
                    ),
                    Text('Qty: ${recycled.qty}'),
                  ],
                ),
              ],
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              DateFormat('yyyy-MM-dd – kk:mm')
                  .format(DateTime.parse(recycled.createdAt)),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              recycled.isPickedUp ? 'Picked' : 'Not picked',
            ),
          ],
        ),
      ],
    );
  }
}

String returnImage(String item) {
  switch (item) {
    case 'Plastic':
      return 'assets/images/plastic.png';
    case 'Cardboard':
      return 'assets/images/box.png';
    case 'Glass':
      return 'assets/images/glass.png';
    case 'Electronics':
      return 'assets/images/electronics.png';
    default:
      return '';
  }
}
