import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterloginwithtodo/addtodo_page.dart';
import 'package:flutterloginwithtodo/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> todoList = [];

  @override
  Widget build(BuildContext context) {
    todoList = Provider.of<TodoProvider>(context, listen: false).todoList;
    return Scaffold(
      appBar: AppBar(
        title: Text("Homee"),
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${todoList[index]}'),
              );
            },
          )),
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
}
