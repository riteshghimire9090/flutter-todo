import 'package:flutter/material.dart';
import 'package:flutterloginwithtodo/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
        title: Text("Register"),
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
                child: Text("Register"),
                onPressed: () {
                  register(context);
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

  void register(ctx) async {
    if (password.text.isEmpty && username.text.isEmpty) {
      setState(() {
        isPasswordValid = false;
      });
    } else {
      bool isSuccess = await Provider.of<AuthProvider>(context, listen: false)
          .registerUser(username.text.trim(), password.text.trim());
      print('---------------------------------------');
      if (isSuccess) goToHome();
    }
  }

  void goToHome() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterPage(),
      ),
    );
  }
}
