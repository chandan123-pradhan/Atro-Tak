import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_group_today_assignment/Screens/SplashScreen.dart';
import 'package:india_group_today_assignment/Utils/Colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Astro Tak',
      theme: ThemeData(
        primarySwatch: Colors.orange
      ),
      home: SplashView(),
    );
  }
}

