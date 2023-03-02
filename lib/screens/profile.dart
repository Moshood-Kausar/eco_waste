import 'package:eco_waste/controller/auth_controller.dart';
import 'package:eco_waste/utils/colors.dart';
import 'package:eco_waste/utils/text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../utils/appbuttons.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthController _authController = Get.find();
  final _formKey = GlobalKey<FormState>();
  int? selectedIndex;
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordd = TextEditingController();
  bool btnLoad = false, _hideshoww = true, _hideShow = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          centerTitle: false,
        ),
        body: SafeArea(
            child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColor.primary,
                ),
              ),
              child: Center(
                child: Text(
                  '${_authController.firestoreUser.value == null ? '' : _authController.firestoreUser.value!.fullName[0]}',
                 
                  style: TextStyle(
                      color: AppColor.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 56),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text(
              '${_authController.firestoreUser.value == null ? '' : _authController.firestoreUser.value!.fullName}',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            Text(
                '${_authController.firestoreUser.value == null ? '' : _authController.firestoreUser.value!.email}'),
            Text(
                '${_authController.firestoreUser.value == null ? '' : _authController.firestoreUser.value!.phone}'),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  AppTextFormField(
                    controller: _fullname,
                    text: 'Full name',
                    hintText: 'Kausar Moshood',
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Empty field detected';
                      } else if (value.length < 2) {
                        return 'Firstname cannot be less than 3 characters';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  AppTextFormField(
                    controller: _email,
                    text: 'Email',
                    hintText: 'your_mail@email.com',
                    icon: const Icon(Icons.email, color: Colors.grey),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      Pattern pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = RegExp(pattern.toString());
                      if (!regex.hasMatch(value!)) {
                        return 'Invalid email address';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  AppTextFormField(
                    controller: _phone,
                    text: 'Phone number',
                    hintText: '0810000***0',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    icon: const Icon(Icons.phone, color: Colors.grey),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Empty field detected';
                      } else if (value.length <= 10) {
                        return 'Number cannot be less than 11 characters';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  Obx(
                    () => _authController.isLoading.value
                        ? const Center(
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.2,
                              ),
                            ),
                          )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width - 20,
                            height: 48.0,
                            child: AppButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    Map<String, String> user = {
                                      "fullName": _fullname.text.trim(),
                                      "email": _email.text.trim(),
                                      "phone": _phone.text.trim(),
                                    };
                                    //update function
                                  }
                                },
                                text: 'Update Profile'),
                          ),
                  )
                ],
              ),
            ),
          ],
        )));
  }
}
