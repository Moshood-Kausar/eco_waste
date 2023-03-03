import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_waste/screens/auth/login.dart';
import 'package:eco_waste/data/user.dart';
import 'package:eco_waste/screens/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<UserModel> firestoreUser = Rxn<UserModel>();
  var isLoading = false.obs;

  @override
  void onReady() async {
    //run every time auth state changes
    ever(firebaseUser, handleAuthChanged);
    firebaseUser.bindStream(user);
    super.onReady();
  }

  handleAuthChanged(_firebaseUser) async {
    //get user data from firestore
    if (_firebaseUser?.uid != null) {
      firestoreUser.bindStream(streamFirestoreUser());
    }

    if (_firebaseUser == null) {
      print('Send to signin');
      Get.offAll(const LoginScreen());
    } else {
      Get.offAll(const DashBoard());
    }
  }

  Stream<User?> get user => _auth.authStateChanges();

  Stream<UserModel> streamFirestoreUser() {
    print('streamFirestoreUser()');

    return _db
        .doc('/users/${firebaseUser.value!.uid}')
        .snapshots()
        .map((snapshot) => UserModel.fromJson(snapshot.data()!));
  }

  //get the firestore user from the firestore collection
  Future<UserModel> getFirestoreUser() {
    return _db.doc('/users/${firebaseUser.value!.uid}').get().then(
        (documentSnapshot) => UserModel.fromJson(documentSnapshot.data()!));
  }

  signInWithEmailAndPassword(
      BuildContext context, Map<String, String> user) async {
    isLoading(true);
    try {
      await _auth.signInWithEmailAndPassword(
          email: user['email'].toString(),
          password: user['password'].toString());
      isLoading(false);
    } catch (error) {
      isLoading(false);
      Get.snackbar('auth.signInErrorTitle'.tr, 'auth.signInError'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

//register user and save details
  registerUserWithEmailAndPassword(
      BuildContext context, Map<String, String> user, var password) async {
    isLoading(true);
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: user['email'].toString(), password: password)
          .then((result) async {
        UserModel _newUser = UserModel(
          uid: result.user!.uid,
          email: result.user!.email!,
          fullName: user['fullName'].toString(),
          phone: user['phone'].toString(),
        );
        //create the user in firestore
        _createUserFirestore(_newUser, result.user!);
        isLoading(false);
      });
    } on FirebaseAuthException catch (err) {
      isLoading(false);
      Get.snackbar(
        'error',
        err.message.toString(),
      );
    }
  }

  //create the firestore user in users collection
  void _createUserFirestore(UserModel user, User _firebaseUser) {
    _db.doc('/users/${_firebaseUser.uid}').set(
          user.toJson(),
        );
    update();
  }

//Sign out current user
  Future<void> signOut() {
    return _auth.signOut();
  }
}
