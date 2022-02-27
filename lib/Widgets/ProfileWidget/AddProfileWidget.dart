import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_group_today_assignment/Bloc/ProfileDataBloc.dart';
import 'package:india_group_today_assignment/Dialogs/LoadingDialogs.dart';
import 'package:india_group_today_assignment/GetXController.dart';
import 'package:india_group_today_assignment/Models/Responses/GetLocationsResponse.dart';
import 'package:india_group_today_assignment/Models/Responses/GetRelativesResponse.dart';
import 'package:india_group_today_assignment/Networking/NetworkConstant.dart';
import 'package:india_group_today_assignment/Networking/Response.dart';
import 'package:india_group_today_assignment/Providers/ApiProvider.dart';
import 'package:india_group_today_assignment/Repository/ProfileRepository.dart';
import 'package:india_group_today_assignment/Utils/Colors.dart';
import 'package:india_group_today_assignment/Utils/TextFieldDecoration.dart';
import 'package:india_group_today_assignment/Widgets/ToastMessageWidget.dart';

class AddProfileWidget extends StatefulWidget {
  GetXController controller;
  Function onBackTap;
  AllRelative? relative;
  bool isForEdit;
  AddProfileWidget(
      {required this.controller,
      required this.onBackTap,
      this.relative,
      required this.isForEdit});

  @override
  _AddProfileWidgetState createState() =>
      _AddProfileWidgetState(controller, onBackTap, relative, isForEdit);
}

class _AddProfileWidgetState extends State<AddProfileWidget> {
  GetXController controller;
  Function onBackTap;
  AllRelative? relative;
  bool isForEdit;
  _AddProfileWidgetState(
      this.controller, this.onBackTap, this.relative, this.isForEdit);
  final _formKey = GlobalKey<FormState>();
  bool isDropDownEnable = false;
  String selectedTime = 'AM';
  String? selectedLocationId;
  String? selectedGender;
  String? selectedRelation;
  TextEditingController name = new TextEditingController();
  TextEditingController dobDay = new TextEditingController();
  TextEditingController dobMonth = new TextEditingController();
  TextEditingController dobYear = new TextEditingController();
  TextEditingController dobHour = new TextEditingController();
  TextEditingController dobMinute = new TextEditingController();
  TextEditingController placeController = new TextEditingController();
  List<LocationsData> locationsList = [];

  bool isGenderValid = true;
  bool isRelationValid = true;
  late ProfileRepository profileRepository;
FocusNode nameNode=new FocusNode();
  FocusNode dateOfBirthNode=new FocusNode();
  FocusNode dateOfMonthNode=new FocusNode();
  FocusNode dateOfYearNode=new FocusNode();
  FocusNode hourNode=new FocusNode();
  FocusNode minuteNode=new FocusNode();
  FocusNode placeNode=new FocusNode();

  void changeTimming(timeValue) {
    setState(() {
      selectedTime = timeValue;
    });
  }

  late ProfileDataBloc _profileDataBloc;

  void initializeAllTextField() {
    print('now we are editing');
    //print(relative);
    setState(() {
      name.text = relative!.fullName;
      dobDay.text = relative!.birthDetails.dobDay.toString();
      dobMonth.text = relative!.birthDetails.dobMonth.toString();
      dobYear.text = relative!.birthDetails.dobYear.toString();
      dobHour.text = relative!.birthDetails.tobHour.toString();
      dobMinute.text = relative!.birthDetails.tobMin.toString();
      placeController.text = relative!.birthPlace.placeName;
      selectedLocationId = relative!.birthPlace.placeId.toString();
      selectedGender = relative!.gender;
      selectedRelation = relative!.relation;
    });
  }


@override
  void dispose() {
   _profileDataBloc.dispose();
    super.dispose();
  }
  @override
  void initState() {
    _profileDataBloc = ProfileDataBloc();
    profileRepository = ProfileRepository();
    if (isForEdit == true) {
      initializeAllTextField();
    }
/**
 * for listen add relatives response.
 */
    _profileDataBloc.addRelativesStream.listen((event) {
      Navigator.pop(context);
      if (event.status == Status.COMPLETED) {
        showSuccessToast(event.data!.message.toString());
        onBackTap();

        if (event.data!.httpStatusCode == 200) {
          onBackTap();
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        onBackTap();
        return Future.value(false);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  setState(() {
                    onBackTap();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Icon(Icons.navigate_before,
                          size: 35, color: Colors.black),
                      Text(
                        " Add New Profile",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text("Name",
                    style: TextStyle(color: Colors.black54, fontSize: 15)),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 20,
                ),
                child: Container(
                 
                  child: TextFormField(
                    focusNode: nameNode,
                    controller: name,
                    decoration: textFieldDecoration(''),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Valid Name';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 0),
                child: Text("Date of Birth",
                    style: TextStyle(color: Colors.black54, fontSize: 15)),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Get.width / 3.6,
                          child: TextFormField(
                            focusNode: dateOfBirthNode,
                            controller: dobDay,
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            decoration: textFieldDecoration('DD'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Invalid DD';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          width: Get.width / 3.6,
                          child: TextFormField(
                            focusNode: dateOfMonthNode,
                            controller: dobMonth,
                            keyboardType: TextInputType.number,

                            maxLength: 2,
                            decoration: textFieldDecoration('MM'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Invalid MM';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          width: Get.width / 3.6,
                          child: TextFormField(
                            focusNode: dateOfYearNode,
                            controller: dobYear,
                            keyboardType: TextInputType.number,

                            maxLength: 4,
                            decoration: textFieldDecoration('YYYY'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Invalid Years';
                              }
                              return null;
                            },
                          ),
                        ),
                      ])),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 0),
                child: Text("Time of Birth",
                    style: TextStyle(color: Colors.black54, fontSize: 15)),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Get.width / 3.6,
                          child: TextFormField(
                            focusNode: hourNode,
                            controller: dobHour,
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            decoration: textFieldDecoration('HH'),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Invalid HH';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          width: Get.width / 3.6,
                          child: TextFormField(
                            focusNode: minuteNode,
                            controller: dobMinute,
                            keyboardType: TextInputType.number,

                            maxLength: 2,
                            decoration: textFieldDecoration('MM'),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Invalid MM';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          width: Get.width / 3.6,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  changeTimming('AM');
                                },
                                child: Container(
                                    width: Get.width / 7.5,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      color: selectedTime == 'AM'
                                          ? Colors.blue
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "AM",
                                      style: TextStyle(
                                          color: selectedTime == 'AM'
                                              ? AppColors.whiteColor
                                              : Colors.black38),
                                    )),
                              ),
                              InkWell(
                                onTap: () {
                                  changeTimming('PM');
                                },
                                child: Container(
                                    width: Get.width / 7.5,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      color: selectedTime == 'PM'
                                          ? Colors.blue
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "PM",
                                      style: TextStyle(
                                          color: selectedTime == 'PM'
                                              ? AppColors.whiteColor
                                              : Colors.black38),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ])),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text("Birth Place",
                    style: TextStyle(color: Colors.black54, fontSize: 15)),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 20,
                ),
                child: Container(
                  child: TextFormField(
                    focusNode: placeNode,
                    controller: placeController,
                    onChanged: (val) {
                      if (val != '') {
                        
                        setState(() {
                          isDropDownEnable = true;
                        });

                        getLocations(val);
                      } else {
                        setState(() {
                          isDropDownEnable = false;
                        });
                      }
                    },
                    decoration: textFieldDecoration(''),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Valid Place';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              isDropDownEnable == true
                  ? Container(child: dropDownWidget())
                  : Container(),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.width / 2.5,
                      alignment: Alignment.centerLeft,
                      child: Text("Gender",
                          style:
                              TextStyle(color: Colors.black54, fontSize: 15)),
                    ),
                    Container(
                      width: Get.width / 2.5,
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text("Relation",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 15)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Get.width / 2.4,
                          height: 55,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2,
                                  color: isGenderValid == true
                                      ? Colors.black12
                                      : Colors.red),
                              borderRadius: BorderRadius.circular(7)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: DropdownButton<String>(
                              icon: Icon(Icons.arrow_drop_down_outlined,
                                  size: 30, color: AppColors.mainColor),
                              underline: Container(),
                              hint: Text('',
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 13,
                                  )),
                              value: selectedGender,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                              isExpanded: true,
                              items: ['MALE', 'FEMALE'].map((value) {
                                return DropdownMenuItem<String>(
                                  value: value.toString(),
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                               unfocusAllTextField(); 
                                print(value);
                                setState(() {
                                  selectedGender = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        isGenderValid == true
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text("Invalid Gender",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)),
                              )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Get.width / 2.4,
                          height: 55,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2,
                                  color: isRelationValid == true
                                      ? Colors.black12
                                      : Colors.red),
                              borderRadius: BorderRadius.circular(7)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: DropdownButton<String>(
                              icon: Icon(Icons.arrow_drop_down_outlined,
                                  size: 30, color: AppColors.mainColor),
                              underline: Container(),
                              hint: Text('',
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 13,
                                  )),
                              value: selectedRelation,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                              isExpanded: true,
                              items: ['Brother', 'Mother', 'Friend', 'Father']
                                  .map((value) {
                                return DropdownMenuItem<String>(
                                  value: value.toString(),
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                unfocusAllTextField();
                                print(value);
                                setState(() {
                                  selectedRelation = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        isRelationValid == true
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text("Invalid Relation",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)),
                              )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                width: Get.width / 1,
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    isForEdit == true ? editProfile() : submit();
                    // setState(() {
                    //   addProfileWidgetEnable = true;
                    // });
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
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                        color: AppColors.mainColor,
                      ),
                      alignment: Alignment.center,
                      child: Text("Save",
                          style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold))),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void editProfile() {
    if (_formKey.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return LoadingDialog();
          });
      String firstName = name.text.split(' ')[0];
      String lastName = name.text.split(' ')[1];
      Map<dynamic, dynamic> data = {
        "uuid": relative!.uuid.toString(),
        "relation": selectedRelation,
        "relationId": relative!.relationId.toString(),
        "firstName": name.text.split(' ')[0],
        "middleName": null,
        "lastName": name.text.split(' ')[1],
        "fullName": name.text,
        "gender": selectedGender,
        "dateAndTimeOfBirth": dobYear.text +
            '-' +
            dobMonth.text +
            '-' +
            dobDay.text +
            ' ' +
            dobHour.text +
            ':' +
            dobMinute.text,
        "birthDetails": {
          "dobYear": dobYear.text,
          "dobMonth": dobMonth.text,
          "dobDay": dobDay.text,
          "tobHour": dobHour.text,
          "tobMin": dobMinute.text,
          "meridiem": selectedTime
        },
        "birthPlace": {
          "placeName": placeController.text,
          "placeId": selectedLocationId
        }
      };
      print(data);

      _profileDataBloc.callEditRelativesData(relative!.uuid.toString(), data);
    }
  }

  void submit() {
    if (selectedGender != null) {
      setState(() {
        isGenderValid = true;
      });
    } else {
      setState(() {
        isGenderValid = false;
      });
    }
    if (selectedRelation != null) {
      setState(() {
        isRelationValid = true;
      });
    } else {
      setState(() {
        isRelationValid = false;
      });
    }

    if (_formKey.currentState!.validate() &&
        isGenderValid == true &&
        isRelationValid == true) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return LoadingDialog();
          });
      String firstName = name.text.split(' ')[0];
      String lastName = name.text.split(' ')[1];
      Map<dynamic, dynamic> data = {
        'birthDetails': {
          'dobDay': dobDay.text,
          'dobMonth': dobMonth.text,
          'dobYear': dobYear.text,
          'tobHour': dobHour.text,
          'tobMin': dobMinute.text,
          'meridiem': selectedTime
        },
        'birthPlace': {
          "placeName": placeController.text,
          "placeId": selectedLocationId
        },
        "firstName": firstName,
        "lastName": lastName,
        "relationId": 3,
        "gender": selectedGender,
      };
      print(data);

      _profileDataBloc.callAddRelativesData(data);
    }
  }

  void getLocations(val) async {
    locationsList.clear();
    GetLocationsResponse chuckCats = await profileRepository.getLocations(val);
    if (chuckCats.httpStatusCode == 200) {
      setState(() {
        print("done succesfully");
        // debugger();
        locationsList.addAll(chuckCats.data);
      });
      // debugger();
      print(locationsList);
    } else {
      setState(() {
        isDropDownEnable = false;
      });
      print(chuckCats.message);
    }
    // return locationsList;
  }

  Widget dropDownWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
      child: Container(
          width: Get.width / 1,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              for (int i = 0; i < locationsList.length; i++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      selectedLocationId = locationsList[i].placeId;
                      placeController.text = locationsList[i].placeName;
                      setState(() {
                        isDropDownEnable = false;
                      });
                    },
                    child: Container(
                      width: Get.width / 1,
                      child: Text(locationsList[i].placeName,
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                    ),
                  ),
                )
            ],
          )),
    );
  }




void unfocusAllTextField(){
    placeNode.unfocus();
                                nameNode.unfocus();
                                dateOfBirthNode.unfocus();
                                dateOfMonthNode.unfocus();
                                dateOfYearNode.unfocus();
                                hourNode.unfocus();
                                minuteNode.unfocus();
                              
}


}
