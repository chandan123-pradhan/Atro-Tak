import 'dart:async';
import 'package:flutter/material.dart';
import 'package:india_group_today_assignment/Screens/DashboardScreen.dart';
import 'package:india_group_today_assignment/Utils/Colors.dart';
import 'package:india_group_today_assignment/Utils/ImageUtils.dart';
import 'package:get/get.dart';
class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));

    Timer(Duration(seconds: 3), () async {
       Get.offAll(DashBoardScreen(index: 2,));
      _controller.dispose();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SlideTransition(
                position: _offsetAnimation,
                child: Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    image: DecorationImage(
                      image: AssetImage(ImageUtils.LOGO),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            
          ],
        ),
      ),
    );
  }
}
