import 'package:flutter/material.dart';
import 'package:flutterloginwithtodo/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var passwordShow = true;

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isEmailValid = true;
  bool isPasswordValid = true;

  IconData passwordVisibilityIcon = Icons.visibility_off;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    // isLogined();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: username,
                decoration: InputDecoration(
                    errorText: isEmailValid ? "" : "Username is r",
                    border: OutlineInputBorder(),
                    hintText: "Username"),
                readOnly: false,
                autofocus: true,
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: password,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    errorText: isPasswordValid ? "" : "Password is r",
                    hintText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisibilityIcon),
                      onPressed: () {
                        setState(() {
                          if (passwordShow == false) {
                            passwordVisibilityIcon = Icons.visibility_off;
                            passwordShow = true;
                          } else {
                            passwordVisibilityIcon = Icons.visibility;
                            passwordShow = false;
                          }
                        });
                      },
                    )),
                readOnly: false,
                autofocus: true,
                obscureText: passwordShow,
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                child: Text("Login"),
                onPressed: () {
                  login(context);
                },
                color: Colors.red,
                textColor: Colors.white,
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login(ctx) async {
    if (password.text.isEmpty && username.text.isEmpty) {
      setState(() {
        isPasswordValid = false;
      });
    } else {
      if (username.text == "r" && password.text == "r") {
        print("login");
        goToHome();
        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setBool(IS_Login, true);
      } else {
        final snackBar = SnackBar(
          content: Text('Wrong Username and Password'),
          action: SnackBarAction(
            label: 'Clear',
            onPressed: () {
              setState(() {
                username.text = "";
                password.text = "";
              });

              // Some code to undo the change.
            },
          ),
        );

        ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
      }
    }
  }

  void goToHome() async {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }
}
