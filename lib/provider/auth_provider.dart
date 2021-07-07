import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  Future<bool> registerUser(String email, String password) async {
    try {
      _auth.createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      // print('Failed with error code: ${e.code}');
      // print(e.message);
      return false;
    }
  }

  void loginPhone(String phone) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
      );
    } on FirebaseAuthException catch (e) {
      // print('Failed with error code: ${e.code}');
      // print(e.message);
    }
  }

  void createCollation() async {
    var user = await _auth.currentUser;
    print(user);
    print("------------------------------------------------------------");

    await FirebaseFirestore.instance
        .collection("users")
        .doc("ritesh")
        .set({"name": "Ritesh ghimire", "boolVal": true});
  }

  bool isLogdedIn() {
    bool isLogin = (_auth.currentUser == null ? false : true);
    return isLogin;
  }
}
