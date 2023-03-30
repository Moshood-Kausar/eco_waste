import 'dart:developer';

import 'package:eco_web/controller/auth_controller.dart';
import 'package:eco_web/utils/text_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/button.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController _authController = Get.put(AuthController());
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passController = TextEditingController();
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(48.0),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppTextFormField(
                        controller: emailController,
                        text: 'Email',
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
                      const SizedBox(
                        height: 48,
                      ),
                      AppTextFormField(
                        controller: passController,
                        text: 'Password',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter password';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      ButtonS(
                          text: 'Login',
                          icon: ': Icons.abc',
                          onPressed: () async {
                            log('clicked');
                            await _authController
                                .signInWithEmailAndPassword(context, {
                              'email': emailController.text.trim().toString(),
                              'password': passController.text.trim().toString(),
                            });
                            // Navigator.pushNamed(context, '/dashboard');
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Image.asset(
              'assets/image/waste_eco.png',
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
