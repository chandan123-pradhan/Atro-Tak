import 'dart:async';

import 'package:india_group_today_assignment/Models/Responses/DeleteRelativesResponse.dart';
import 'package:india_group_today_assignment/Models/Responses/GetCategoryResponse.dart';
import 'package:india_group_today_assignment/Networking/Response.dart';
import 'package:india_group_today_assignment/Repository/AskRepository.dart';
import 'package:india_group_today_assignment/Repository/ProfileRepository.dart';



class DeleteRelativeDataBloc{
  late ProfileRepository profileRepository;
  late StreamController<Response<DeleteRelativesResponse>> streamController;

  StreamSink<Response<DeleteRelativesResponse>> get deleteRelativeSink =>
      streamController.sink;

  Stream<Response<DeleteRelativesResponse>> get deleteRelativeStream =>
      streamController.stream;

  DeleteRelativeDataBloc() {
    streamController = StreamController<Response<DeleteRelativesResponse>>();
    profileRepository = ProfileRepository();

  }

  callDeleteRelativeApi(url) async {
    try {
      DeleteRelativesResponse chuckCats =
      await profileRepository.deleteRelatives(url);
      print("-------------this is data");
      print(chuckCats);
      deleteRelativeSink.add(Response.completed(chuckCats));
      
    } catch (e) {
      deleteRelativeSink.add(Response.error(e.toString()));
      print(e);
    }
  }



  dispose() {
    streamController.close();
  }
}