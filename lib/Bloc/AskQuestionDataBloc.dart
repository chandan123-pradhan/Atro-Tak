import 'dart:async';

import 'package:india_group_today_assignment/Models/Responses/GetCategoryResponse.dart';
import 'package:india_group_today_assignment/Networking/Response.dart';
import 'package:india_group_today_assignment/Repository/AskRepository.dart';



class AskQuestionBloc{
  late AskRepository userRepository;
  late StreamController<Response<GetCategoryResponse>> streamController;

  StreamSink<Response<GetCategoryResponse>> get getCategorySink =>
      streamController.sink;

  Stream<Response<GetCategoryResponse>> get getCategoryStream =>
      streamController.stream;

  AskQuestionBloc() {
    streamController = StreamController<Response<GetCategoryResponse>>();
    userRepository = AskRepository();

  }

  callGetCategoryApi() async {
    try {
      GetCategoryResponse chuckCats =
      await userRepository.getCategory();
      print("-------------this is data");
      print(chuckCats);
      getCategorySink.add(Response.completed(chuckCats));
      
    } catch (e) {
      getCategorySink.add(Response.error(e.toString()));
      print(e);
    }
  }



  dispose() {
    streamController.close();
  }
}