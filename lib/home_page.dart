import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterloginwithtodo/add_todo_page.dart';
import 'package:flutterloginwithtodo/model/todo.dart';
import 'package:flutterloginwithtodo/widgets/todo_widget.dart';

class HomePage extends StatefulWidget {
  // List<Todo> todoList = [];
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('todo').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<DocumentSnapshot> documents = snapshot.data.docs;
              documents.map((e) {
                print(e['title']);
              });
              return ListView(
                  children: documents
                      .map(
                        (doc) => TodoWidget(
                          Todo(
                            id: doc.id,
                            note: doc['note'],
                            color: doc['color'],
                          ),
                        ),
                      )
                      .toList());
            } else if (snapshot.hasError) {
              return Text('Its Error!');
            } else {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTodo(),
            ),
          );
        },
        child: Icon(
          (Icons.add),
        ),
      ),
    );
  }
}
