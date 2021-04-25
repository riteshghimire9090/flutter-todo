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
    todoList = Provider.of<TodoProvider>(context, listen: true).todoList;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: isTodo(),
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

  Widget isTodo() {
    if (Provider.of<TodoProvider>(context, listen: false).todoList.isEmpty) {
      return Center(
        child: Text(
          "No Todo's Found ",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0),
        ),
      );
    } else {
      return Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${todoList[index]}'),
                trailing: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Provider.of<TodoProvider>(context, listen: false)
                        .removeTodo(todoList[index]);
                  },
                ),
              );
            },
          ));
    }
  }
}
