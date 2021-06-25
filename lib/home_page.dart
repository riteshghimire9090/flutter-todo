import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterloginwithtodo/addtodo_page.dart';
import 'package:flutterloginwithtodo/provider/todo_provider.dart';
import 'package:provider/provider.dart';

import 'model/Todo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> todoList = [];

  @override
  Widget build(BuildContext context) {
    todoList = Provider.of<TodoProvider>(context, listen: true).todoList;
    get();
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Home")),
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

  void get() async {
    Todo todo =
        await Provider.of<TodoProvider>(context, listen: false).getTodo(1);
    print(todo.note);
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
              print(todoList);
              return ListTile(
                title: Text('${todoList[index].note}'),
                trailing: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Provider.of<TodoProvider>(context, listen: false)
                        .removeTodo(todoList[index].id);
                  },
                ),
                leading: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddTodo(
                            id: todoList[index].id,
                            note: todoList[index].note,
                            isEditing: true),
                      ),
                    );
                  },
                ),
              );
            },
          ));
    }
  }
}
