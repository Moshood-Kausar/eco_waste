import 'package:eco_waste/utils/appbuttons.dart';
import 'package:eco_waste/utils/text_form.dart';
import 'package:flutter/material.dart';

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
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
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
                    height: 200,
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
                                    Navigator.pushNamed(context, '/dashboard');
                                    _isLoading = true;
                                  });
                                  // try {
                                  //   await FirebaseAuth.instance
                                  //       .signInWithEmailAndPassword(
                                  //           email: _email!.text.trim(),
                                  //           password: _password!.text)
                                  //       .then(
                                  //     (value) {
                                  //       _isLoading = false;

                                  //    // db.child(value.user!.payment)

                                  //       // db.child(value.user!.uid).update({
                                  //       //   "payment": false,
                                  //       // });
                                  //       getUserInfo(uid: value.user!.uid);
                                  //     },
                                  //       ).timeout(timeOut);
                                  //     } on SocketException catch (_) {
                                  //       snackBar(nointernet);
                                  //     } on TimeoutException catch (_) {
                                  //       snackBar(timeMsg);
                                  //     } on FirebaseAuthException catch (e) {
                                  //       if (e.code == 'user-not-found') {
                                  //         snackBar(
                                  //             'No student found with that email.');
                                  //       } else if (e.code == 'wrong-password') {
                                  //         snackBar(
                                  //             'Wrong Password provided by Student.');
                                  //       } else {
                                  //         snackBar('${e.message}');
                                  //       }
                                  //     }
                                  //     setState(() {
                                  //       _isLoading = false;
                                  //     });
                                }
                              },
                              text: 'Login'),
                        )
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text('Does not have an account?Sign Up'))
          ],
        ),
      )),
    );
  }
}
