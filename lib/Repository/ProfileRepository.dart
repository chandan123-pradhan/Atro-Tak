import 'package:india_group_today_assignment/Models/Responses/AddRelativesResponse.dart';
import 'package:india_group_today_assignment/Models/Responses/DeleteRelativesResponse.dart';
import 'package:india_group_today_assignment/Models/Responses/GetCategoryResponse.dart';
import 'package:india_group_today_assignment/Models/Responses/GetLocationsResponse.dart';
import 'package:india_group_today_assignment/Models/Responses/GetRelativesResponse.dart';
import 'package:india_group_today_assignment/Networking/NetworkConstant.dart';
import 'package:india_group_today_assignment/Providers/ApiProvider.dart';

class ProfileRepository {
  ApiProvider _apiProvider = ApiProvider();
  Future<GetRelativesResponse> getRelativesList() async {
    final response =
        await _apiProvider.getAfterAuth(NetworkConstant.END_POINT_GET_RELATIVES_LIST);
    return GetRelativesResponse.fromJson(response);
  }



  Future<AddRelativesResponse> addRelatives(Map data) async {
    final response =
        await _apiProvider.postAfterAuth(NetworkConstant.END_POINT_ADD_RELATIVES,
        data
        );
    return AddRelativesResponse.fromJson(response);
  }


Future<AddRelativesResponse> editRelatives(String url,Map data) async {
    final response =
        await _apiProvider.postAfterAuth(NetworkConstant.END_POINT_UPDATE_RELATIVE_PROFILE+url,
        data
        );
    return AddRelativesResponse.fromJson(response);
  }



Future<GetLocationsResponse> getLocations(url) async {
    final response =
        await _apiProvider.get(NetworkConstant.END_POINT_OF_GET_LOCATIONS+'inputPlace=$url');
    return GetLocationsResponse.fromJson(response);
  }


Future<DeleteRelativesResponse> deleteRelatives(url) async {
    final response =
        await _apiProvider.postAfterAuth(NetworkConstant.END_POINT_OF_DELTE_USERS+url,{});
    return DeleteRelativesResponse.fromJson(response);
  }


}
