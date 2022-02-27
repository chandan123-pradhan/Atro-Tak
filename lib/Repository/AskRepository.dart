import 'package:india_group_today_assignment/Models/Responses/GetCategoryResponse.dart';
import 'package:india_group_today_assignment/Networking/NetworkConstant.dart';
import 'package:india_group_today_assignment/Providers/ApiProvider.dart';

class AskRepository {
  ApiProvider _apiProvider = ApiProvider();
  Future<GetCategoryResponse> getCategory() async {
    final response =
        await _apiProvider.get(NetworkConstant.END_PONIT_GET_CATEGORY);
    return GetCategoryResponse.fromJson(response);
  }
}
