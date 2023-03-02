import 'package:eco_waste/utils/colors.dart';
import 'package:flutter/material.dart';

class Learn extends StatefulWidget {
  const Learn({super.key});

  @override
  State<Learn> createState() => _LearnState();
}

class _LearnState extends State<Learn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Learn',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            Text('Why disposing of trash is essential'),
          ],
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0),
          child: Column(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Expanded(
                    child: posts(),
                  ))
            ],
          ),
        )),
      ),
    );
  }

  Widget posts({String? title, subtitle, pic}) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 26,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
        });
  }
}
