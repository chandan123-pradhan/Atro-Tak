import 'dart:async';

import 'package:india_group_today_assignment/Models/Responses/AddRelativesResponse.dart';
import 'package:india_group_today_assignment/Models/Responses/GetCategoryResponse.dart';
import 'package:india_group_today_assignment/Models/Responses/GetLocationsResponse.dart';
import 'package:india_group_today_assignment/Models/Responses/GetRelativesResponse.dart';
import 'package:india_group_today_assignment/Networking/Response.dart';
import 'package:india_group_today_assignment/Repository/AskRepository.dart';
import 'package:india_group_today_assignment/Repository/ProfileRepository.dart';

class ProfileDataBloc {
  late ProfileRepository getRelativeRepository;
  late StreamController<Response<GetRelativesResponse>> streamController;
  late StreamController<Response<AddRelativesResponse>>
      addRelativesStreamController;
  StreamSink<Response<GetRelativesResponse>> get getRelativesSink =>
      streamController.sink;

  Stream<Response<GetRelativesResponse>> get getRelativesStream =>
      streamController.stream;

  StreamSink<Response<AddRelativesResponse>> get addRelativesSink =>
      addRelativesStreamController.sink;

  Stream<Response<AddRelativesResponse>> get addRelativesStream =>
      addRelativesStreamController.stream;
  ProfileDataBloc() {
    streamController = StreamController<Response<GetRelativesResponse>>();
    addRelativesStreamController =
        StreamController<Response<AddRelativesResponse>>();
    getRelativeRepository = ProfileRepository();
  }

  callGetRelativesApi() async {
    try {
      GetRelativesResponse chuckCats =
          await getRelativeRepository.getRelativesList();
      print("-------------this is data");
      print(chuckCats);
      getRelativesSink.add(Response.completed(chuckCats));
    } catch (e) {
      getRelativesSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  callAddRelativesData(parameter) async {
    try {
      AddRelativesResponse chuckCats =
          await getRelativeRepository.addRelatives(parameter);
      print("-------------this is data");
      print(chuckCats);
      addRelativesSink.add(Response.completed(chuckCats));
    } catch (e) {
      addRelativesSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  callEditRelativesData(url,parameter) async {
    try {
      AddRelativesResponse chuckCats =
          await getRelativeRepository.editRelatives(url,parameter);
      print("-------------this is data");
      print(chuckCats);
      addRelativesSink.add(Response.completed(chuckCats));
    } catch (e) {
      addRelativesSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    streamController.close();
    addRelativesStreamController.close();
  }
}
