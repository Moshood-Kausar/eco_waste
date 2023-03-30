import 'package:eco_waste/controller/auth_controller.dart';
import 'package:eco_waste/utils/appbuttons.dart';
import 'package:eco_waste/utils/colors.dart';
import 'package:eco_waste/utils/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  // DatabaseReference db =
  //     FirebaseDatabase.instance.reference().child("Students");

  TextEditingController? _email, _password;
  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final AuthController _authController = Get.find();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Sign In'),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  AppTextFormField(
                    controller: _email,
                    text: 'Email',
                    hintText: 'your_mail@email.com',
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Empty field detected';
                      } else if (value.length < 6) {
                        return 'email cannot be less than 6 characters';
                      } else if (!value.contains('@')) {
                        return 'Invalid email address entered';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  AppTextFormField(
                    controller: _password,
                    secure: true,
                    text: 'Password',
                    hintText: 'Enter your password',
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Empty field detected';
                      } else if (value.length < 6) {
                        return 'password cannot be less than 6 characters';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 100),
                  Obx(
                    () => _authController.isLoading.value
                        ? Center(
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: SpinKitThreeBounce(
                                color: AppColor.primary,
                                size: 16,
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
                                      'email': _email!.text,
                                      'password': _password!.text,
                                    };
                                    await _authController
                                        .signInWithEmailAndPassword(
                                      context,
                                      user,
                                    );
                                  }
                                },
                                text: 'Login'),
                          ),
                  )
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/signup',
                );
              },
              child: const Text('Does not have an account?Sign Up'),
            )
          ],
        ),
      )),
    );
  }
}
