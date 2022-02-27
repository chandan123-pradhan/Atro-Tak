import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_group_today_assignment/Utils/Colors.dart';
import 'package:india_group_today_assignment/Widgets/ProfileWidget/BasicProfileTab.dart';
import 'package:india_group_today_assignment/Widgets/ProfileWidget/FriendAndFamilyProfileTabWidget.dart';


class MyProfileWidget extends StatefulWidget {
  const MyProfileWidget({ Key? key }) : super(key: key);

  @override
  _MyProfileWidgetState createState() => _MyProfileWidgetState();
}

class _MyProfileWidgetState extends State<MyProfileWidget> {
   int selectedTab = 0;
 
   void changeTab(tabValue) {
    setState(() {
      selectedTab = tabValue;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 1,
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            width: Get.width / 1,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: InkWell(
                    onTap: () {
                      changeTab(0);
                    },
                    child: Container(
                        width: Get.width / 2.23,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: selectedTab == 0
                                ? AppColors.mainColor
                                : AppColors.whiteColor),
                        alignment: Alignment.center,
                        child: Text("Basic Profile",
                            style: TextStyle(
                                color: selectedTab == 0
                                    ? AppColors.whiteColor
                                    : Colors.black54,
                                fontSize: 13,
                                fontWeight: FontWeight.w500))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: () {
                      changeTab(1);
                    },
                    child: Container(
                        width: Get.width / 2.23,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: selectedTab == 1
                                ? AppColors.mainColor
                                : AppColors.whiteColor),
                        alignment: Alignment.center,
                        child: Text("Friends and Family Profile",
                            style: TextStyle(
                                color: selectedTab == 1
                                    ? AppColors.whiteColor
                                    : Colors.black54,
                                fontSize: 13,
                                fontWeight: FontWeight.w500))),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: selectedTab == 0
                ? BasicProfileWidget()
                : FriendAndFamilyProfileTabWidget(),
          )
        ],
      ),
    );
  }
}