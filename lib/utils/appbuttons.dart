import 'package:eco_waste/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

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
        width: 160,
        height: 60,
        child: MaterialButton(
            elevation: 0,
            height: 74,
            minWidth: 10,
            color: AppColor.primary,
            onPressed: onPressed,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            child: Row(children: [
              //SvgPicture.asset(icon),
              SizedBox(width: 6),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xffffffff),
                  fontFamily: 'Mulish',
                ),
              ),
            ])));
  }
}

class AppButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const AppButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 52,
      child: Container(
        decoration: const BoxDecoration(
            // boxShadow: <BoxShadow>[
            //   BoxShadow(
            //     color: Color.fromRGBO(0, 39, 166, 0.12),
            //     blurRadius: 20,
            //     offset: Offset(0, 17),
            //   ),
            // ],
            ),
        child: MaterialButton(
          elevation: 0.5,
          height: 52,
          minWidth: 10,
          color: AppColor.primary,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: const Color(0xffffffff),
              fontFamily: 'Mulish',
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonSO extends StatelessWidget {
  final String text, icon;
  final void Function() onPressed;
  const ButtonSO(
      {Key? key,
      required this.icon,
      required this.text,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 104,
      height: 32,
      child: OutlinedButton(
        style: ButtonStyle(
          side: MaterialStateProperty.all(
              BorderSide(color: AppColor.primary, width: 1.0)),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            SvgPicture.asset(icon),
            SizedBox(width: 6),
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: AppColor.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
