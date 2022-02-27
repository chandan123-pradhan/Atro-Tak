import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:india_group_today_assignment/Networking/NetworkConstant.dart';

class ApiProvider {
  String token =
      "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI4ODA5NzY1MTkxIiwiUm9sZXMiOltdLCJleHAiOjE2NzY0NjE0NzEsImlhdCI6MTY0NDkyNTQ3MX0.EVAhZLNeuKd7e7BstsGW5lYEtggbSfLD_aKqGFLpidgL7UHZTBues0MUQR8sqMD1267V4Y_VheBHpxwKWKA3lQ";
  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(NetworkConstant.baseUrl + url));
      responseJson = jsonDecode(response.body);
      print(responseJson);
    } catch (e) {}
    return responseJson;
  }

  Future<dynamic> getAfterAuth(String url) async {
    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(NetworkConstant.baseUrl + url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          'Authorization': 'Bearer $token'
        },
      );
      responseJson = jsonDecode(response.body);
      print(responseJson);
    } catch (e) {}
    return responseJson;
  }

  Future<dynamic> postAfterAuth(String url,Map prameter) async {
    print("----");
    var responseJson;
    try {
      final response = await http.post(
        Uri.parse(NetworkConstant.baseUrl + url),
        body: jsonEncode(prameter),
        
        headers: {
         "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
      );
      print(jsonDecode(response.body));
      responseJson = jsonDecode(response.body);
      print(responseJson);
    } catch (e) {
      print(e);
    }
    return responseJson;
  }
}
