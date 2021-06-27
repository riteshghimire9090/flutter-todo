import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterloginwithtodo/constants/constants.dart';
import 'package:flutterloginwithtodo/home_page.dart';
import 'package:flutterloginwithtodo/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogin = false;
  @override
  void initState() {
    // TODO: implement initState
    checkLogin();
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              builder: (context) => LoginPage(
                title: "Hello",
              ),
            ),
            (route) => false);
  }

  void checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    isLogin = prefs.getBool(IS_Login) ?? false;
  }
}
