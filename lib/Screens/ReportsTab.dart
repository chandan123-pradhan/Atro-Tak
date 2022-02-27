import 'package:flutter/material.dart';

class ReportsTab extends StatefulWidget {
  const ReportsTab({ Key? key }) : super(key: key);

  @override
  _ReportsTabState createState() => _ReportsTabState();
}

class _ReportsTabState extends State<ReportsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:Text("Reports Tab")),
    );
  }
}