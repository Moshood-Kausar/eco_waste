import 'package:eco_waste/utils/colors.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.ontap,
    required this.title,
    required this.buttoncolor,
    required this.buttontext,
    required this.color,
    required this.pic,
    required this.subtitle,
    required this.txtColor,
  });
  final String? title, subtitle, buttontext, pic;
  final Color? txtColor, buttoncolor, color;
  final ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: MediaQuery.of(context).size.width - 100,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$title',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: txtColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '$subtitle',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                      color: txtColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: ontap,
                  color: AppColor.primary,
                  child: Text(
                    '$buttontext',
                    style: TextStyle(
                      color: buttoncolor,
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
