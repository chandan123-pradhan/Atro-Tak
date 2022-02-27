import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:india_group_today_assignment/Dialogs/InternetConnenctionAlertDialog.dart';
import 'package:india_group_today_assignment/Screens/AskQuestionTab.dart';
import 'package:india_group_today_assignment/Screens/ChatsTab.dart';
import 'package:india_group_today_assignment/Screens/HomeTab.dart';
import 'package:india_group_today_assignment/Screens/ReportsTab.dart';
import 'package:india_group_today_assignment/Screens/TaskTab.dart';
import 'package:india_group_today_assignment/Utils/Colors.dart';

class DashBoardScreen extends StatefulWidget {
  int index;
  DashBoardScreen({required this.index});
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState(index);
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int index;
  _DashBoardScreenState(this.index);

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  int currentIndex = 0;

  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("Double tap to exit");
      // Errormessage("press again to exit");
      return Future.value(false);
    } else {
      //  print("done");
      //
      return Future.value(true);
    }
  }

  changeIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  List tabs = [
    HomeTab(),
    TaskTab(),
    AskQuestionTab(),
    ReportsTab(),
    ChatsTab()
  ];

  @override
  void initState() {
    changeIndex(index);
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
    if (_connectionStatus == ConnectivityResult.none) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return InterntConnectionAlertDialog(
                errorMessage: 'Your Internet Connections is off');
          });
    } else {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        child: tabs[currentIndex],
        onWillPop: () async {
          bool backStatus = await onWillPop();
          if (backStatus) {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            //  exit(0);
          }
          return false;
        },
      ),
      bottomNavigationBar: Container(
        height: 70.0,
        child: BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getBottomBarItemTile(0, Icons.home_outlined, 'Home'),
              getBottomBarItemTile(1, Icons.copy, 'Report'),
              getBottomBarItemTile(
                  2, Icons.question_answer_outlined, 'Ask Question'),
              getBottomBarItemTile(
                  3, Icons.report_gmailerrorred_outlined, 'Task'),
              getBottomBarItemTile(4, Icons.message_rounded, 'Chats'),
            ],
          ),
        ),
      ),
    );
  }

  getBottomBarItemTile(int index, icon, title) {
    return InkWell(
      borderRadius: BorderRadius.circular(30.0),
      focusColor: AppColors.mainColor,
      onTap: () {
        changeIndex(index);
      },
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            // height: 50.0,
            width: 50.0,
            alignment: Alignment.center,
            child: Icon(icon,
                size: 25.0,
                color: (currentIndex == index)
                    ? AppColors.mainColor
                    : Colors.black38),
          ),
          SizedBox(height: 5),
          Text(title,
              style: TextStyle(
                  color: (currentIndex == index)
                      ? AppColors.mainColor
                      : Colors.black38))
        ],
      ),
    );
  }
}
