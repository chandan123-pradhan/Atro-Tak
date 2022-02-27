import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_group_today_assignment/Bloc/DeleteRelativeDataBloc.dart';
import 'package:india_group_today_assignment/Bloc/ProfileDataBloc.dart';
import 'package:india_group_today_assignment/Dialogs/DeleteAlertDialogBox.dart';
import 'package:india_group_today_assignment/Dialogs/LoadingDialogs.dart';
import 'package:india_group_today_assignment/GetXController.dart';
import 'package:india_group_today_assignment/Models/Responses/GetRelativesResponse.dart';
import 'package:india_group_today_assignment/Networking/Response.dart';
import 'package:india_group_today_assignment/Utils/Colors.dart';
import 'package:india_group_today_assignment/Widgets/ProfileWidget/AddProfileWidget.dart';
import 'package:india_group_today_assignment/Widgets/ShimeersEffect.dart';
import 'package:india_group_today_assignment/Widgets/ToastMessageWidget.dart';
import 'package:intl/intl.dart';

class FriendAndFamilyProfileTabWidget extends StatefulWidget {
  const FriendAndFamilyProfileTabWidget({Key? key}) : super(key: key);

  @override
  _FriendAndFamilyProfileTabWidgetState createState() =>
      _FriendAndFamilyProfileTabWidgetState();
}

class _FriendAndFamilyProfileTabWidgetState
    extends State<FriendAndFamilyProfileTabWidget> {
  bool addProfileWidgetEnable = false;
  late ProfileDataBloc profileDataBloc;
  List<AllRelative> relativesList = [];
  AllRelative? relativeData;
  final GetXController getXController = Get.put(GetXController());
  bool isLoading = true;
  late DeleteRelativeDataBloc deleteRelativeBloc;
  bool isForEdit=false;

@override
  void dispose() {
    deleteRelativeBloc.dispose();
    profileDataBloc.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    profileDataBloc = ProfileDataBloc();
    deleteRelativeBloc = DeleteRelativeDataBloc();
/**
 * for listen deletion of relatives.
 */
    deleteRelativeBloc.deleteRelativeStream.listen((event) {
      Navigator.pop(context);
      showSuccessToast(event.data!.message);
      if (event.status == Status.COMPLETED) {
        setState(() {});
        profileDataBloc.callGetRelativesApi();
      }
    });

/**
 * for listen list of relatives.
 */
    profileDataBloc.getRelativesStream.listen((event) {
      setState(() {
        isLoading = false;
      });
      if (event.status == Status.COMPLETED) {
        if (event.data!.httpStatusCode == 200) {
          setState(() {
            relativesList.clear();
            relativesList.addAll(event.data!.data.allRelatives);
            
          });
        } else {
          showErrorToast(event.message.toString());
        }
      } else {
        print(event.message);
      }
    });

    profileDataBloc.callGetRelativesApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: getXController.isAddProfileEnable == true
          ? AddProfileWidget(
              controller: getXController,
              onBackTap: () {
                getXController.changeScreen(false);
                setState(() {});

                profileDataBloc.callGetRelativesApi();
              },
              relative: relativeData,
              isForEdit: isForEdit,
            )
          : Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.account_balance_wallet_outlined,
                              size: 25,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Wallet Ballance ₹ 0",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          width: 1, color: Colors.blue)),
                                  alignment: Alignment.center,
                                  child: Text("Add Money",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold))),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        width: Get.width / 5.5,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          " Name",
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                      ),
                      Container(
                        width: Get.width / 5,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "DOB",
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                      ),
                      Container(
                        width: Get.width / 5.5,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "TOB",
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                      ),
                      Container(
                        width: Get.width / 5.5,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Relation",
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  isLoading == true
                      ? ShimmersEffectWidget()
                      : relativesList.length==0?
                      Container(
                        child:Center(
                          child:Padding(
                            padding: const EdgeInsets.only(top:20),
                            child: Text("No Relatives Available",
                            style:TextStyle(color:Colors.black54,fontSize:15)
                            ),
                          )
                        )
                      ):
                      
                      ListView.builder(
                          itemCount: relativesList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, index) {
                            return relativesCard(
                              relativesList[index],
                            );
                          }),
                  SizedBox(height: 40),
                  isLoading == true
                      ? Container()
                      : InkWell(
                          onTap: () {
                            getXController.changeScreen(true);
                            setState(() {});
                          },
                          child: Container(
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                                color: AppColors.mainColor,
                              ),
                              alignment: Alignment.center,
                              child: Text("+ Add new profile",
                                  style: TextStyle(
                                      color: AppColors.whiteColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))),
                        ),
                  SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  Widget relativesCard(AllRelative relative) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Container(
        width: Get.width / 1,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
            border: Border.all(width: 1, color: Colors.black12)),
        child: Padding(
          padding: const EdgeInsets.only(left: 2, right: 2),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Get.width / 5.5,
                alignment: Alignment.centerLeft,
                child: Text(
                  relative.fullName,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                width: Get.width / 5,
                alignment: Alignment.centerLeft,
                child: Text(
                  DateFormat('yyyy-MM-dd')
                      .format(relative.dateAndTimeOfBirth)
                      .toString(),
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                width: Get.width / 5.5,
                alignment: Alignment.centerLeft,
                child: Text(
                  DateFormat('kk:mm')
                      .format(relative.dateAndTimeOfBirth)
                      .toString(),
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                width: Get.width / 5.5,
                alignment: Alignment.centerLeft,
                child: Text(
                  relative.relation,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ),
              InkWell(
                onTap:(){
                  
                  setState((){
                    isForEdit=true;
                    relativeData=relative;

                  });
                  getXController.changeScreen(true);
                },
                
                child: Icon(Icons.edit, size: 20, color: AppColors.mainColor)),
              Expanded(
                  child: InkWell(
                      onTap: () {
                        // Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DeleteAlertDialogBox(
                                onDelete: () {
                                  Navigator.pop(context);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return LoadingDialog();
                                      });
                                  deleteRelativeBloc
                                      .callDeleteRelativeApi(relative.uuid);
                                },
                              );
                            });
                      },
                      child: Icon(Icons.delete, size: 20, color: Colors.red))),
            ],
          ),
        ),
      ),
    );
  }
}
