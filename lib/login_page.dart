import 'package:flutter/material.dart';
import 'package:flutterloginwithtodo/provider/auth_provider.dart';
import 'package:flutterloginwithtodo/register_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var passwordShow = true;

  TextEditingController email = TextEditingController();
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
        title: Text("Login"),
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
                controller: email,
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
              RaisedButton(
                child: Text("Login with Phone "),
                onPressed: () {
                  loginWithPhone(context);
                },
                color: Colors.red,
                textColor: Colors.white,
              ),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                child: Text("Register"),
                onPressed: () {
                  goToRegisterPage();
                },
                color: Colors.red,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login(ctx) async {
    if (password.text.isEmpty && email.text.isEmpty) {
      setState(() {
        isPasswordValid = false;
      });
    } else {
      if (email.text == "r" && password.text == "r") {
        print("login");
        bool isSuccess = await Provider.of<AuthProvider>(context, listen: false)
            .loginUser(email.text.trim(), password.text.trim());
        if (isSuccess) {
          goToHome();
        }
      } else {
        final snackBar = SnackBar(
          content: Text('Wrong Username and Password'),
          action: SnackBarAction(
            label: 'Clear',
            onPressed: () {
              setState(() {
                email.text = "";
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

  void loginWithPhone(ctx) async {
    if (password.text.isEmpty && email.text.isEmpty) {
      setState(() {
        isPasswordValid = false;
      });
    } else {
      if (email.text == "r" && password.text == "r") {
        print("login");
        Provider.of<AuthProvider>(context, listen: false)
            .loginPhone(email.text.trim());
        goToHome();
      } else {
        final snackBar = SnackBar(
          content: Text('Wrong Username and Password'),
          action: SnackBarAction(
            label: 'Clear',
            onPressed: () {
              setState(() {
                email.text = "";
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
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => RegisterPage()),
        (route) => false);
  }

  void goToRegisterPage() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => RegisterPage()),
        (route) => false);
  }
}
