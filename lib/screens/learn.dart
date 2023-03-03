import 'package:eco_waste/utils/colors.dart';
import 'package:eco_waste/utils/widget/learn_widget.dart';
import 'package:flutter/material.dart';

class Learn extends StatefulWidget {
  const Learn({super.key});

  @override
  State<Learn> createState() => _LearnState();
}

class _LearnState extends State<Learn> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Learn',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            Text('Why disposing of trash is essential'),
          ],
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width,
              height: 230,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      LearnCard(
                          title: 'Waste Sorting tips',
                          subtitle: 'Damilola',
                          buttontext: 'Turn On Location',
                          color: AppColor.primary,
                          txtColor: Colors.white,
                          buttoncolor: AppColor.primary),
                      LearnCard(
                          color: AppColor.mintgreen,
                          title: 'Environmental tips',
                          subtitle: 'Damilola',
                          buttontext: 'Notify us',
                          txtColor: AppColor.primary,
                          buttoncolor: Colors.white),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'Awareness',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 6,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return const AwarenessItems();
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
