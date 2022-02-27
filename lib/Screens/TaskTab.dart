import 'package:flutter/material.dart';

class TaskTab extends StatefulWidget {
  const TaskTab({ Key? key }) : super(key: key);

  @override
  _TaskTabState createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:Text("Task Tab")),
    );
  }
}