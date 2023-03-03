import 'package:eco_waste/utils/colors.dart';
import 'package:flutter/material.dart';

class TrashCenterItem extends StatelessWidget {
  const TrashCenterItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.withOpacity(0.08),
              // boxShadow: [
              //   BoxShadow(
              //     color: const Color(0xffe5e5e5).withOpacity(0.25),
              //     blurRadius: 14,
              //     offset: const Offset(0, 11),
              //   )
              // ],
            ),
            child: ListTile(
              isThreeLine: true,
              // leading: Image.asset('assets/images/boardone.png'),
              title: Text(
                'MayFair Waste Management',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColor.primary,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                        '34, Oduduwa University Estate Ife-Ile beside my mum\'s house '),
                  ),
                ],
              ),
              trailing: Icon(
                Icons.message,
                color: AppColor.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
