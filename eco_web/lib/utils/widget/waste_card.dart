import 'package:eco_web/controller/waste_controller.dart';
import 'package:eco_web/utils/color.dart';
import 'package:flutter/material.dart';

class WasteCard extends StatelessWidget {
  const WasteCard({
    super.key,
    required this.image,
    required this.date,
    required this.isPicked,
    required this.landmark,
    required this.location,
    required this.coordinate,
    required this.id,
    required this.wasteController,
  });

  final String image, landmark, location, date, coordinate;
  final int id;
  final bool isPicked;
  final WasteController wasteController;

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
                    Image.network(
                      image,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          landmark,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          location,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          date,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      isPicked ? 'Cleared' : 'Not cleared',
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
                                  title: Text(landmark),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              isPicked
                                                  ? 'Cleared'
                                                  : 'Not Cleared',
                                              style: const TextStyle(
                                                  color: Colors.red),
                                            ),
                                            MaterialButton(
                                                color: WebColor.primary,
                                                textColor: Colors.white,
                                                onPressed: () {},
                                                child:
                                                    const Text('Locate on Map'))
                                          ],
                                        ),
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
                                              await wasteController
                                                  .updatePickup(id);
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
