import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutterloginwithtodo/addtodo_page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'widgets/todo_widget.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final storage = new FlutterSecureStorage();
  TextEditingController todos = TextEditingController();

  String todo = "";
  String response = "";
  bool _validate = false;

  @override
  void initState() {
    fetchTodo();
    super.initState();
  }

  void fetchTodo() async {
    String value = await storage.read(key: "todo") ?? "";
    setState(() {
      todo = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView(
          children: [
            TodoWidget(todo, listColor: Colors.red),
            TodoWidget(todo),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTodo(),
            ),
          );
        },
      ),
    );
  }

  inputField(BuildContext ctx) {
    setState(() {
      todos.text = "";
    });
    Alert(
            context: ctx,
            title: "",
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: todos,
                  decoration: InputDecoration(
                    hintText: "Coding.....",
                    border: OutlineInputBorder(),
                    errorText: _validate ? 'Value Can\'t Be Empty' : null,
                  ),
                ),
                RaisedButton(
                  child: Text("Add to TODO"),
                  color: Colors.red,
                  onPressed: () {
                    if (todos.text == null || todos.text == "") {
                      _validate = true;
                    } else {
                      Navigator.pop(ctx);
                      setState(() {
                        todo = todos.text;
                      });
                      storeTodo();
                    }
                  },
                  textColor: Colors.white,
                )
              ],
            ),
            desc: "")
        .show();
  }

  void storeTodo() async {
    await storage.write(key: "todo", value: todos.text);
  }
}
