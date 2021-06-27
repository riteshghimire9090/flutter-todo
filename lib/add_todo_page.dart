import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutterloginwithtodo/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class AddTodo extends StatefulWidget {
  final bool isEditing;
  final String note;
  final int id;
  AddTodo({this.id = 0, this.note = "", this.isEditing = false});

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final storage = new FlutterSecureStorage();
  TextEditingController todo = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      todo.text = widget.isEditing ? widget.note : "";
    });
    // this.todo.text = widget.isEditing ? widget.note : "hello";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? "Update Todo" : "Add to Todo"),
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
            ElevatedButton(
              child: Text(
                widget.isEditing ? "Update Todo" : "Add to Todo",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                addTodos(context);
                // addTodos(widget.id);
              },
            )
          ],
        ),
      ),
    );
  }

  void addTodos(BuildContext ctx) async {
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
      if (widget.isEditing) {
        Provider.of<TodoProvider>(context, listen: false)
            .updateTodo(widget.id, todo.text);
        // await storage.write(key: "todo", value: todo.text);
        Navigator.pop(context);
      } else {
        Provider.of<TodoProvider>(context, listen: false).addTodo(todo.text);
        // await storage.write(key: "todo", value: todo.text);
        Navigator.pop(context);
      }
    }
  }
}
