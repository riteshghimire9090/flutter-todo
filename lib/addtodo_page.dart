import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutterloginwithtodo/home_page.dart';

class AddTodo extends StatefulWidget {
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final storage = new FlutterSecureStorage();
  TextEditingController todo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add todos"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            TextField(
              controller: todo,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Coding ....",
              ),
            ),
            RaisedButton(
              child: Text("Add to Todo's"),
              onPressed: () {
                addTodos(context);
              },
              color: Colors.blue,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  void addTodos(ctx) async {
    if (todo.text.isEmpty) {
      final snackBar = SnackBar(
        content: Text("Please enter your todo's"),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
    } else {
      await storage.write(key: "todo", value: todo.text);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    }
  }
}
