import 'package:eco_waste/utils/colors.dart';
import 'package:flutter/material.dart';

class AwarenessItems extends StatelessWidget {
  const AwarenessItems({
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
              color: Color(0xFF9E9E9E).withOpacity(0.08),
              // boxShadow: [
              //   BoxShadow(
              //     color: const Color(0xffe5e5e5).withOpacity(0.25),
              //     blurRadius: 14,
              //     offset: const Offset(0, 11),
              //   )
              // ],
            ),
            child: ListTile(
                leading: Image.asset('assets/images/trassh.jpeg'),
                title: Text(
                  'Disposal food waste',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                    'A step by step mopping process outlining what a user ...')),
          ),
        ],
      ),
    );
  }
}

class LearnCard extends StatelessWidget {
  const LearnCard({
    super.key,
    this.buttoncolor,
    this.buttontext,
    this.color,
    this.pic,
    this.subtitle,
    this.title,
    this.txtColor,
  });
  final String? title, subtitle, buttontext, pic;

  final Color? buttoncolor, txtColor, color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 380,
          width: 170,
          decoration: BoxDecoration(
            color: AppColor.grey.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    //color: Colors.yellow,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/trash1.jpg',
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8,
                  top: 12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$title',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColor.primary,
                            backgroundImage:
                                AssetImage('assets/images/boardone.png'),
                            radius: 12,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '$subtitle',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          )),
    );
  }
}
