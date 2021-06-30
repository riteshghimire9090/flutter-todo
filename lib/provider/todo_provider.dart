import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutterloginwithtodo/constants/constants.dart';
import 'package:flutterloginwithtodo/database/db_helper.dart';
import 'package:flutterloginwithtodo/model/todo.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todoList = [];
  Todo todo;
  var db = DBHelper();

  List<Todo> get todoList => UnmodifiableListView(_todoList);

  void addTodo(String note, {int color = whiteColor}) {
    Todo todo =
        Todo(id: _todoList.length + 1, note: note, color: color.toString());
    _todoList.add(todo);
    db.saveTodo(todo);
    notifyListeners();
  }

  void readAllTodo() async {
    _todoList = await db.getAllTodo();
    notifyListeners();
  }

  void removeTodo(int id) {
    // Todo todo = Todo(id: id);
    _todoList.remove(todo);
    db.deleteTodo(id);
    notifyListeners();
  }

  Future<Todo> getTodo(int id) async {
    return todo = await db.getTodo(id);
  }

  void updateTodo(int id, String note, int color) {
    Todo todo = Todo(id: id, note: note, color: color.toString());
    db.updateTodo(todo);
    _todoList.insert(id, todo);
    notifyListeners();
  }
}
