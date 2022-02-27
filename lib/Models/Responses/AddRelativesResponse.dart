
import 'dart:convert';

AddRelativesResponse addRelativesResponseFromJson(String str) => AddRelativesResponse.fromJson(json.decode(str));

String addRelativesResponseToJson(AddRelativesResponse data) => json.encode(data.toJson());

class AddRelativesResponse {
    AddRelativesResponse({
        required this.httpStatus,
        required this.httpStatusCode,
        required this.success,
        required this.message,
        required this.apiName,
    });

    String httpStatus;
    int httpStatusCode;
    bool success;
    String message;
    String apiName;

    factory AddRelativesResponse.fromJson(Map<String, dynamic> json) => AddRelativesResponse(
        httpStatus: json["httpStatus"],
        httpStatusCode: json["httpStatusCode"],
        success: json["success"],
        message: json["message"],
        apiName: json["apiName"],
    );

    Map<String, dynamic> toJson() => {
        "httpStatus": httpStatus,
        "httpStatusCode": httpStatusCode,
        "success": success,
        "message": message,
        "apiName": apiName,
    };
}
