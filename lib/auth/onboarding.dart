import 'package:eco_waste/utils/colors.dart';
import 'package:eco_waste/utils/images.dart';
import 'package:eco_waste/utils/appbuttons.dart';
import 'package:eco_waste/utils/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  List<String> texts = [AppTexts.txt1, AppTexts.txt2, AppTexts.txt3];
  List<String> stexts = [AppTexts.stxt1, AppTexts.stxt2, AppTexts.stxt3];
  List<String> images = [
    AppImages.splash1,
    AppImages.splash2,
    AppImages.splash3
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              images[currentIndex],
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
            ),

            Text(
              texts[currentIndex],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              stexts[currentIndex],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 70,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < images.length; i++)
                    i == currentIndex
                        ? circleIndicator(true)
                        : circleIndicator(false)
                ]),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                currentIndex == 2
                    ? const Center()
                    : TextButton(
                        onPressed: () {
                          setState(() => currentIndex = 2);
                        },
                        child: Text(
                          'SKIP',
                          style: TextStyle(
                              color: AppColor.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                TextButton(
                  onPressed: () {
                    if (currentIndex == 2) {
                      // Navigator.pushReplacementNamed(context, '/homepage');
                    } else {
                      setState(() => currentIndex++);
                    }
                  },
                  child: Text(
                    currentIndex == 2 ? '' : 'NEXT',
                    style: TextStyle(
                        color: AppColor.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 45,
              child: Container(
                decoration: const BoxDecoration(),
                child: MaterialButton(
                  elevation: 0,
                  height: 52,
                  minWidth: 10,
                  color: AppColor.primary,
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: const Color(0xffffffff),
                      fontFamily: 'Mulish',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Center(child: Text('This is an On boarding Screen')),
          ],
        ),
      )),
    );
  }

  Widget circleIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: 3,
      width: 20,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: isActive ? AppColor.primary : Colors.grey,
          shape: BoxShape.rectangle),
    );
  }
}
