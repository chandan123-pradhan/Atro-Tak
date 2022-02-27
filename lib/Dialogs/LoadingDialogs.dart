import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_group_today_assignment/Utils/Colors.dart';


class LoadingDialog extends StatefulWidget {
  const LoadingDialog({ Key? key }) : super(key: key);

  @override
  _LoadingDialogState createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {


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
      backgroundColor: Colors.transparent,
      child: Center(
        
        child: CircularProgressIndicator(
          
        ))   );
  }
}