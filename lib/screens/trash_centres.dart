import 'package:eco_waste/utils/colors.dart';
import 'package:flutter/material.dart';

class TrashCentres extends StatefulWidget {
  const TrashCentres({super.key});

  @override
  State<TrashCentres> createState() => _TrashCentresState();
}

class _TrashCentresState extends State<TrashCentres> {
  final TextEditingController _searchController = TextEditingController();
  String strValue = '';

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nearby Trash Centres',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            Text('Locate the nearest trash sorting & recycle \n depot'),
          ],
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              TextFormField(
                controller: _searchController,
                cursorColor: const Color(0xff525252),
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  fillColor: const Color(0xffF4F4F4),
                  filled: true,
                  isDense: true,
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  contentPadding:
                      const EdgeInsets.only(left: 10.0, right: 0.0, top: 12),
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.primary)),
                  hintText: 'Search for the nearest trash centre',
                ),
                onChanged: (value) {
                  strValue = value;
                  setState(() {});
                },
                // textCapitalization: TextCapitalization.characters,
              ),
              SizedBox(height: 10),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Expanded(
                       
                        child: posts(),
                      ),
                    ],
                  ),),
            ],
          ),
        ),
      )),
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
                        Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                  '34, Oduduwa University Estate Ife-Ile beside my mum\'s house '),
                            ),
                          ],
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
