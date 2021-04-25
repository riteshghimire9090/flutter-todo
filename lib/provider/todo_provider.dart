import 'package:flutter/material.dart';

class TodoProvider extends ChangeNotifier {
  List<String> todoList = [];

  void addTodo(String todo) {
    todoList.add(todo);
    notifyListeners();
  }

  void removeTodo(String todo) {
    todoList.remove(todo);
    notifyListeners();
  }
}
