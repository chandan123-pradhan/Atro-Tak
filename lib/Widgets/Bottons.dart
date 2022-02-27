import 'package:flutter/material.dart';
import 'package:india_group_today_assignment/Utils/Colors.dart';

class MainBotton extends StatelessWidget {
  Color bgColor;
  String title;
  MainBotton({required this.bgColor, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: bgColor,
      borderRadius: BorderRadius.circular(5)),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
            color: AppColors.blueColor,
            fontSize: 15,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
