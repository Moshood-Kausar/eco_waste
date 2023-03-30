import 'package:flutter/material.dart';

class ButtonS extends StatelessWidget {
  final String text, icon;
  final void Function() onPressed;
  const ButtonS(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onPressed,
      double? width,
      double? height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: MaterialButton(
            elevation: 0,
            height: 74,
            minWidth: 10,
            color: Colors.green,
            onPressed: onPressed,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 24,
                color: Color(0xffffffff),
                fontFamily: 'Mulish',
              ),
            )));
  }
}
