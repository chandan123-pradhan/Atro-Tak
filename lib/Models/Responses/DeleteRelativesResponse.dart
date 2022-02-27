
import 'dart:convert';

DeleteRelativesResponse deleteRelativesResponseFromJson(String str) => DeleteRelativesResponse.fromJson(json.decode(str));

String deleteRelativesResponseToJson(DeleteRelativesResponse data) => json.encode(data.toJson());

class DeleteRelativesResponse {
    DeleteRelativesResponse({
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

    factory DeleteRelativesResponse.fromJson(Map<String, dynamic> json) => DeleteRelativesResponse(
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
