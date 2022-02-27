import 'dart:convert';

GetCategoryResponse getCategoryResponseFromJson(String str) =>
    GetCategoryResponse.fromJson(json.decode(str));

String getCategoryResponseToJson(GetCategoryResponse data) =>
    json.encode(data.toJson());

class GetCategoryResponse {
  GetCategoryResponse({
    required this.httpStatus,
    required this.httpStatusCode,
    required this.success,
    required this.message,
    required this.apiName,
    required this.data,
  });

  String httpStatus;
  int httpStatusCode;
  bool success;
  String message;
  String apiName;
  List<CategoryData> data;

  factory GetCategoryResponse.fromJson(Map<String, dynamic> json) =>
      GetCategoryResponse(
        httpStatus: json["httpStatus"],
        httpStatusCode: json["httpStatusCode"],
        success: json["success"],
        message: json["message"],
        apiName: json["apiName"],
        data: List<CategoryData>.from(
            json["data"].map((x) => CategoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "httpStatus": httpStatus,
        "httpStatusCode": httpStatusCode,
        "success": success,
        "message": message,
        "apiName": apiName,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CategoryData {
  CategoryData({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.suggestions,
  });

  int id;
  String name;
  String description;
  String price;
  List<String> suggestions;

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        id: json["id"],
        name: json["name"],
        description: json["description"].toString(),
        price: json["price"].toString(),
        suggestions: List<String>.from(json["suggestions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description == null ? null : description,
        "price": price,
        "suggestions": List<dynamic>.from(suggestions.map((x) => x)),
      };
}
