import 'package:flutter/material.dart';
import 'package:flutterloginwithtodo/database/db_helper.dart';
import 'package:flutterloginwithtodo/model/Todo.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> todoList = [];
  Todo todo;
  var db = DBHelper();

  void addTodo(String note) {
    Todo todo = Todo(id: todoList.length + 1, note: note);
    todoList.add(todo);
    db.saveTodo(todo);
    notifyListeners();
  }

  void readAllTodo() async {
    todoList = await db.getAllTodo();
    notifyListeners();
  }

  void removeTodo(int id) {
    // Todo todo = Todo(id: id);
    db.deleteTodo(id);
    notifyListeners();
  }

  Future<Todo> getTodo(int id) async {
    return todo = await db.getTodo(id);
  }

  void updateTodo(int id, String note) {
    Todo todo = Todo(id: id, note: note);
    db.updateTodo(todo);
    todoList.insert(id, todo);
    notifyListeners();
  }
}
