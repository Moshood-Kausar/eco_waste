import 'package:eco_waste/controller/recycle_controller.dart';
import 'package:eco_waste/data/recycled.dart';
import 'package:eco_waste/screens/recycle/recycle_item.dart';
import 'package:eco_waste/utils/appbuttons.dart';
import 'package:eco_waste/utils/colors.dart';
import 'package:eco_waste/utils/text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecycleScreen extends StatelessWidget {
  const RecycleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Let\'s Recycle',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 13.0,
                    color: Color.fromARGB(13, 0, 0, 0),
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Number of Items recycled.'),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: const [
                        RecycleItems(
                          image: 'assets/images/plastic.png',
                          title: 'Plastics',
                          value: '0',
                        ),
                        RecycleItems(
                          image: 'assets/images/glass.png',
                          title: 'Glass',
                          value: '0',
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: const [
                        RecycleItems(
                          image: 'assets/images/box.png',
                          title: 'Carboard',
                          value: '0',
                        ),
                        RecycleItems(
                          image: 'assets/images/electronics.png',
                          title: 'Electronics',
                          value: '0',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Recycling',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: ((context, index) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColor.maingrey,
                                  child: Image.asset(
                                    'assets/images/plastic.png',
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Item type'),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text('10'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('10-29-2020'),
                            const SizedBox(
                              height: 4,
                            ),
                            Text('Picked up'),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primary,
        onPressed: () {
          String dropdownvalue = 'Plastic';
          showModalBottomSheet(
            isDismissible: false,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
            ),
            builder: ((context) {
              return const RecycleBottomModal();
            }),
          );
        },
        child: const Icon(
          Icons.recycling,
        ),
      ),
    );
  }
}

class RecycleBottomModal extends StatefulWidget {
  const RecycleBottomModal({super.key});

  @override
  State<RecycleBottomModal> createState() => _RecycleBottomModalState();
}

TextEditingController amount = TextEditingController();

var items = [
  'Plastic',
  'Cardboard',
  'Electronics',
  'Glass',
];

class _RecycleBottomModalState extends State<RecycleBottomModal> {
  // @override
  // void dispose() {
  //   amount.dispose();
  //   super.dispose();
  // }
  String? dropdownvalue;

  @override
  Widget build(BuildContext context) {
    final RecycleController recycleController = Get.find();
    return SizedBox(
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Type',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color(0xff525252),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DropdownButton(
                    value: dropdownvalue,
                    hint: const Text('Select item type'),
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(
                        () {
                          dropdownvalue = newValue!;
                        },
                      );
                      // validator: (value)=> value == null ? 'field required' : null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  AppTextFormField(
                    maxLength: 20,
                    controller: amount,
                    text: 'QTY',
                    hintText: '0',
                    keyboardType: TextInputType.number,
                    icon: const Icon(Icons.scale_outlined, color: Colors.grey),
                    // textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Empty field detected';
                      } else if (value.length < 2) {
                        return 'Enter quantity';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  AppButton(
                      onPressed: () async {
                        String qty = amount.text.toString();

                        if (qty.isNotEmpty && dropdownvalue!.isNotEmpty) {
                          Recycled recycled = Recycled(
                              userId: '',
                              item: dropdownvalue.toString(),
                              qty: qty,
                              isPickedUp: false,
                              createdAt: DateTime.now().toString());
                          await recycleController.postRecycle(recycled);
                        }
                      },
                      text: 'Recycle'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
