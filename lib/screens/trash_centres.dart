import 'package:flutter/material.dart';

class TrashCentres extends StatefulWidget {
  const TrashCentres({super.key});

  @override
  State<TrashCentres> createState() => _TrashCentresState();
}

class _TrashCentresState extends State<TrashCentres> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: const [
          Center(
            child: Text('Trash Centres'),
          )
        ],
      )),
    );
  }
}