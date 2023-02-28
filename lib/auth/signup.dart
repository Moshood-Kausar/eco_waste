import 'package:eco_waste/utils/appbuttons.dart';
import 'package:eco_waste/utils/text_form.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  int? selectedIndex;
  TextEditingController? _fullname, _email, _phone, _password, _passwordd;
  bool btnLoad = false, _hideshoww = true, _hideShow = true;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Sign In'),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
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
                  AppTextFormField(
                    controller: _password,
                    secure: _hideShow,
                    text: 'Password',
                    hintText: '••••••••',
                    textInputAction: TextInputAction.next,
                    icon: IconButton(
                      onPressed: () {
                        setState(() {
                          _hideShow = !_hideShow;
                        });
                      },
                      icon:
                          const Icon(Icons.remove_red_eye, color: Colors.grey),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Empty field detected';
                      } else if (value.length < 6) {
                        return '6 characters or more required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  AppTextFormField(
                    controller: _passwordd,
                    secure: _hideshoww,
                    text: 'Confirm Password',
                    hintText: '••••••••',
                    textInputAction: TextInputAction.done,
                    icon: IconButton(
                      onPressed: () {
                        setState(() {
                          _hideshoww = !_hideshoww;
                        });
                      },
                      icon:
                          const Icon(Icons.remove_red_eye, color: Colors.grey),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Empty field detected';
                      } else if (value != _password!.text) {
                        return "Password doesn't match";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 100),
                  _isLoading
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
                                  setState(() {
                                    _isLoading = true;
                                  });
                                }
                              },
                              text: 'Login'),
                        )
                ],
              ),
            ),
            //Spacer(),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('Al;ready have an account? Sign In'))
          ],
        ),
      )),
    ));
  }
}
