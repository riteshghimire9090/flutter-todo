import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterloginwithtodo/home_page.dart';
import 'package:flutterloginwithtodo/login_page.dart';
import 'package:flutterloginwithtodo/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogin = false;
  @override
  void initState() {
    // TODO: implement initState
    firebaseInit();
    // checkLogin();
    startTime();
    super.initState();
  }

  void firebaseInit() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    isLogin = Provider.of<AuthProvider>(context, listen: false).isLogdedIn();
    return Scaffold(
      body: Center(
        child: Container(
          height: 250,
          width: 250,
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 100,
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(250),
          ),
        ),
      ),
    );
  }

  startTime() async {
    var _duration = Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    isLogin
        ? Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
            (route) => false)
        : Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
            (route) => false);
  }

  // void checkLogin() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   isLogin = prefs.getBool(IS_Login) ?? false;
  // }
}
