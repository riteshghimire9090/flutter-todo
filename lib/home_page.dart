import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterloginwithtodo/add_todo_page.dart';
import 'package:flutterloginwithtodo/provider/todo_provider.dart';
import 'package:flutterloginwithtodo/widgets/todo_widget.dart';
import 'package:provider/provider.dart';

import 'model/todo.dart';

class HomePage extends StatelessWidget {
  List<Todo> todoList = [];

  @override
  Widget build(BuildContext context) {
    todoList = Provider.of<TodoProvider>(context, listen: true).todoList;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Home")),
      ),
      body: isTodo(context),
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

  Widget isTodo(BuildContext context) {
    if (Provider.of<TodoProvider>(context, listen: false).todoList.isEmpty) {
      return Center(
        child: Text(
          "No Todo's Found ",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return TodoWidget(todoList[index]);
        },
      );
    }
  }
}
