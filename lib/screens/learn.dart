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
      body: SafeArea(
          child: Column(
        children: const [
          Center(
            child: Text('Learn'),
          )
        ],
      )),
    );
  }
}