import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_group_today_assignment/Utils/Colors.dart';

class InterntConnectionAlertDialog extends StatelessWidget {
  final String errorMessage;
InterntConnectionAlertDialog({required this.errorMessage});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
            //  crossAxisAlignment: CrossAxisAlignmen.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 40),
                  child: Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style:TextStyle(color: Colors.black,fontSize:15,)
                       
                  ),
                ),
                 InkWell(
                  
                    onTap: () {
                      exit(0);
                   //  onDelete();
                     },
                    child: Container(
                      height: 40,
                      width: Get.width/2,
                      decoration: BoxDecoration(
                        boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(5)),
                      alignment: Alignment.center,
                      child: Text('OK',
                          style:
                          TextStyle(
                            color:Colors.white,
                            fontSize:16,fontWeight:FontWeight.bold
                          )
                          ),
                    ),
                  ),
                  SizedBox(height:10),
                 
               ],
            ),
          )
        ],
      ),
    );
  }
}
