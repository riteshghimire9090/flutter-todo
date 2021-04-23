import 'package:flutter/material.dart';

class TodoWidget extends StatelessWidget {
  final String todo;
  Color listColor;

  TodoWidget(this.todo, {this.listColor = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: listColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            todo,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
