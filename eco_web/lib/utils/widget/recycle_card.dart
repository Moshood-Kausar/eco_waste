import 'package:eco_web/controller/recycle.controller.dart';
import 'package:eco_web/controller/waste_controller.dart';
import 'package:eco_web/utils/color.dart';
import 'package:flutter/material.dart';

class RecycleCard extends StatelessWidget {
  const RecycleCard({
    super.key,
    required this.date,
    required this.isPicked,
    required this.qty,
    required this.type,
    required this.recycleController,
    required this.index,
  });

  final String type, qty, date;
  final bool isPicked;
  final int index;
  final RecycleController recycleController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width / 3.7,
          color: WebColor.maingrey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: WebColor.maingrey,
                        child: Image.asset(
                          'assets/image/plastic.png',
                        )),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(type),
                        const SizedBox(
                          height: 4,
                        ),
                        Text('Qty: $qty'),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(date),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      isPicked ? 'Picked' : 'Not Picked',
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child: MaterialButton(
                        color: WebColor.primary,
                        textColor: Colors.white,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('MayFair House'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(type),
                                            Text(
                                              isPicked
                                                  ? 'Picked up'
                                                  : ' Not Picked',
                                              style: const TextStyle(
                                                  color: Colors.red),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Qty: $qty'),
                                            MaterialButton(
                                                color: WebColor.primary,
                                                textColor: Colors.white,
                                                onPressed: () {},
                                                child:
                                                    const Text('Locate on Map'))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    Visibility(
                                      visible: !isPicked ? true : false,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          TextButton(
                                            child: Row(
                                              children: const [
                                                Icon(
                                                  Icons.cancel,
                                                  color: Colors.red,
                                                ),
                                                Text('Not Picked',
                                                    style: TextStyle(
                                                        color: Colors.red)),
                                              ],
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Row(
                                              children: [
                                                Text('Picked',
                                                    style: TextStyle(
                                                        color:
                                                            WebColor.primary)),
                                                Icon(
                                                  Icons.check,
                                                  color: WebColor.primary,
                                                )
                                              ],
                                            ),
                                            onPressed: () async {
                                              await recycleController
                                                  .updatePickup(index);
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: const Text(
                          'Locate & Pick Up',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
