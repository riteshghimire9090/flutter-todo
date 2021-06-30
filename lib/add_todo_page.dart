import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutterloginwithtodo/constants/constants.dart';
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
  int colour;
  List colors = [blueColor, whiteColor, redColor];

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: todo,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Coding ....",
              ),
            ),
            Container(
              height: 80.0,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  // separatorBuilder: (BuildContext context, int index) =>
                  //     Divider(
                  //       color: Colors.red,
                  //       thickness: 50.0,
                  //       height: 60,
                  //     ),
                  itemCount: colors.length,
                  padding: EdgeInsets.all(16.0),
                  itemBuilder: (BuildContext cxt, int index) {
                    return colourSelect(colors[index]);
                  }),
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

  Widget colourSelect(int colour) {
    return FloatingActionButton(
      backgroundColor: Color(colour),
      onPressed: () {
        setState(() {
          this.colour = colour;
        });
        print(colour);
      },
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
            .updateTodo(widget.id, todo.text, colour);
        // await storage.write(key: "todo", value: todo.text);
        Navigator.pop(context);
      } else {
        Provider.of<TodoProvider>(context, listen: false)
            .addTodo(todo.text, color: colour);
        // await storage.write(key: "todo", value: todo.text);
        Navigator.pop(context);
      }
    }
  }
}
