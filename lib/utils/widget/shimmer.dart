import 'package:eco_waste/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatefulWidget {
  const CustomShimmer({super.key});

  @override
  State<CustomShimmer> createState() => _CustomShimmerState();
}

class _CustomShimmerState extends State<CustomShimmer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              SizedBox(height: 25),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 10,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            height: 140,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColor.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: 5,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Container(
                                        height: 10,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: AppColor.grey,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                          SizedBox(height: 25),
                        ],
                      );
                    }),
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
