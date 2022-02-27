import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_group_today_assignment/Utils/Colors.dart';
import 'package:india_group_today_assignment/Utils/ImageUtils.dart';
import 'package:india_group_today_assignment/Utils/TextFieldDecoration.dart';
import 'package:india_group_today_assignment/Widgets/ProfileWidget/ProfileScreenWidget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedTab = 0;
  void changeTab(tabValue) {
    setState(() {
      selectedTab = tabValue;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          leading: IconButton(
            icon: Icon(Icons.navigate_before,
                size: 35, color: AppColors.mainColor),
            onPressed: () {
              Get.back();
            },
          ),
          elevation: 1.0,
          centerTitle: true,
          title: Image.asset(ImageUtils.LOGO,height:60,width:100),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                  onTap: () {
                    // Get.to(ProfileScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: 1, color: AppColors.mainColor)),
                        alignment: Alignment.center,
                        child: Text("Logout",
                            style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold))),
                  )),
            )
          ],
          bottom: TabBar(
            unselectedLabelColor: Colors.black87,
            labelColor: AppColors.mainColor,
            tabs: [
              Tab(child: tabItem('My Profile')),
              Tab(child: tabItem('Order History')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MyProfileWidget(),
            OrderHistoryTab(),
          ],
        ),
      ),
    );
  }

  tabItem(text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 15),
        ),
        SizedBox(width: 4.0),
      ],
    );
  }

  

  Widget OrderHistoryTab() {
    return Center(child: Text("Order History Tab"));
  }

 }
