import 'package:eco_waste/utils/colors.dart';
import 'package:flutter/material.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({
    super.key,
  });

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
            child: ListTile(
              isThreeLine: true,
              leading: Image.asset('assets/images/trassh.jpeg'),
              title: Text(
                'A Dump Site',
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
                  Text('MayFair Junction')
                ],
              ),
              trailing: Text('20-03-2023'),
            ),
          ),
        ],
      ),
    );
  }
}
