import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_group_today_assignment/Bloc/DeleteRelativeDataBloc.dart';
import 'package:india_group_today_assignment/Utils/Colors.dart';


class DeleteAlertDialogBox extends StatefulWidget {
  Function onDelete;
  DeleteAlertDialogBox({required this.onDelete});
  @override
  _DeleteAlertDialogBoxState createState() => _DeleteAlertDialogBoxState(onDelete);
}

class _DeleteAlertDialogBoxState extends State<DeleteAlertDialogBox> {

Function onDelete;
_DeleteAlertDialogBoxState(this.onDelete);

@override
  void initState() {
    
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: Container(
          height: Get.height /5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Do you want to delete?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                  
                    onTap: () {
                     onDelete();
                     },
                    child: Container(
                      height: 40,
                      width: Get.width/3,
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
                      child: Text('Yes',
                          style:
                          TextStyle(
                            color:Colors.white,
                            fontSize:16,fontWeight:FontWeight.bold
                          )
                          ),
                    ),
                  ),
                   InkWell(
                  
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 40,
                       width: Get.width/3,
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
                      child: Text('No',
                          style:
                          TextStyle(
                            color:Colors.white,
                            fontSize:16,fontWeight:FontWeight.bold
                          )
                          ),
                    ),
                  ),
                               ],
              )
            ],
          )),
    );
  }
}