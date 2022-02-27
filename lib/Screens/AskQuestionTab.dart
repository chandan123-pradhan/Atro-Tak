import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:india_group_today_assignment/Bloc/AskQuestionDataBloc.dart';
import 'package:india_group_today_assignment/Models/Responses/GetCategoryResponse.dart';
import 'package:india_group_today_assignment/Networking/Response.dart';
import 'package:india_group_today_assignment/Screens/ProfileScreen.dart';
import 'package:india_group_today_assignment/Utils/Colors.dart';
import 'package:india_group_today_assignment/Utils/ImageUtils.dart';
import 'package:india_group_today_assignment/Utils/TextFieldDecoration.dart';
import 'package:india_group_today_assignment/Widgets/Bottons.dart';
import 'package:india_group_today_assignment/Widgets/ToastMessageWidget.dart';

class AskQuestionTab extends StatefulWidget {
  const AskQuestionTab({Key? key}) : super(key: key);

  @override
  _AskQuestionTabState createState() => _AskQuestionTabState();
}

class _AskQuestionTabState extends State<AskQuestionTab> {
  String? selectedCategory;
  TextEditingController questionController = new TextEditingController();
  List<CategoryData> categoryList = [];
  List<String> questionList = [];
  late AskQuestionBloc _askQuestionBloc;
  FocusNode questionBoxNode=new FocusNode();

  @override
  void initState() {
    _askQuestionBloc = AskQuestionBloc();

    _askQuestionBloc.getCategoryStream.listen((event) {
      if (event.status == Status.COMPLETED) {
        if (event.data!.httpStatusCode == 200) {
          setState(() {
            categoryList.addAll(event.data!.data);
            questionList.addAll(categoryList[0].suggestions);
            selectedCategory=categoryList[0].name;
          });
        } else {
         showErrorToast(event.message.toString());
          
        }
      } else {
       showErrorToast(event.message.toString());
      }
    });

    _askQuestionBloc.callGetCategoryApi();
    super.initState();
  }



  @override
  void dispose() {
    _askQuestionBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: AppColors.appBarBackgroundColor,
        leading: Icon(Icons.menu, size: 30, color: AppColors.mainColor),
        centerTitle: true,
        title:Image.asset(ImageUtils.LOGO,height:60,width:100),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10,top:12,bottom:12),
            child: InkWell(
              onTap: () {
                Get.to(ProfileScreen())!.then((value){
                  questionBoxNode.unfocus();
                });
              },
              child: Image.asset(ImageUtils.PROFILE_ICON,height:40)
            ),
          )
        ],
      ),
      body: Container(
        height: Get.height / 1,
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
                height: Get.height / 14,
                color: Colors.blue[900],
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Wallet Amount: ₹ 10",
                        style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 100,
                        height: 25,
                        child: MainBotton(
                            title: "Add Money", bgColor: AppColors.whiteColor),
                      ),
                    ],
                  ),
                )),
            Container(
              height: Get.height / 1.5,
              width: Get.width / 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Ask a Question",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s?",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Choose Category",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Container(
                        height: 60,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: DropdownButton<String>(
                            icon: Icon(Icons.arrow_drop_down_outlined,
                                size: 30, color: AppColors.mainColor),
                            underline: Container(),
                            hint: Text('Category',
                                style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 13,
                                )),
                            value: selectedCategory,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            isExpanded: true,
                            items: categoryList.map((CategoryData value) {
                              return DropdownMenuItem<String>(
                                onTap: () {
                                  questionList.clear();
                                  setState(() {
                                    questionList.addAll(value.suggestions);
                                  });
                                },
                                value: value.name,
                                child: Text(
                                  value.name,
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              print(value);
                              setState(() {
                                selectedCategory = value;
                                //  questionList.addAll(value.);
                              });
                            },
                          ),
                        )),
                    SizedBox(height: 20),
                    Container(
                      // height: 50,
                      child: TextField(
                        focusNode: questionBoxNode,
                        controller: questionController,
                        keyboardType: TextInputType.multiline,
                        maxLength: 150,
                        maxLines: 5,
                        //textAlignVertical: TextAlignVertical.bottom,
                        decoration: textFieldDecoration('Type question here')
                      
                        
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                        child: ListView(
                      children: [
                        Text(
                          "Ideas what to ask (Select Any)",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        ListView.builder(
                            itemCount: questionList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 5, bottom: 5),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      questionController.text =
                                          questionList[index];
                                    });
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 2,
                                                  color: Colors.black12))),
                                      width: Get.width / 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                width: 30,
                                                child: Icon(Icons.help_center,
                                                    color: AppColors.mainColor)),
                                           SizedBox(width:5),
                                            Expanded(
                                                child: Text(questionList[index],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold)))
                                          ],
                                        ),
                                      )),
                                ),
                              );
                            }),
                        SizedBox(height: 15),
                        Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s?",
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.red[50],
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(children: [
                            for (int i = 0; i < 5; i++)
                              Container(
                                width: Get.width / 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, left: 10, bottom: 5, right: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Container(
                                            height: 8,
                                            width: 8,
                                            decoration: BoxDecoration(
                                              color: AppColors.mainColor,
                                              shape: BoxShape.circle,
                                            )),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          "This is a dummy widgets which only showing dumy data.",
                                          style: TextStyle(
                                              color: AppColors.mainColor,
                                              fontSize: 15),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                          ]),
                        ),
                        SizedBox(height: 15),
                      ],
                    ))
                  ],
                ),
              ),
            ),
           Container(
               height: Get.height / 14,
                decoration: BoxDecoration(
                  color: Colors.blue[900],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₹ 150(1 Question on Love)",
                        style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        width: 100,
                        height: 35,
                        child: MainBotton(
                            title: "Ask Now", bgColor: AppColors.whiteColor),
                      ),
                    ],
                  ),
                ),
              ),
            
          ]),
        ),
      ),
    );
  }
}
