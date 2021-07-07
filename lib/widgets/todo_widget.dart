import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterloginwithtodo/add_todo_page.dart';
import 'package:flutterloginwithtodo/model/todo.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;
  CollectionReference todos = FirebaseFirestore.instance.collection('todo');

  TodoWidget(this.todo);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        color: Color(int.parse(todo.color)),
        borderRadius: BorderRadius.circular(20),
        child: ListTile(
          title: Text(todo.note),
          trailing: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              todos
                  .doc(todo.id)
                  .delete()
                  .then((value) => print("User Deleted"))
                  .catchError(
                      (error) => print("Failed to delete user: $error"));
            },
          ),
          leading: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTodo(
                    id: todo.id,
                    note: todo.note,
                    isEditing: true,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
