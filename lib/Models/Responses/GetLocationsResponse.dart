
import 'dart:convert';

GetLocationsResponse getLocationsResponseFromJson(String str) => GetLocationsResponse.fromJson(json.decode(str));

String getLocationsResponseToJson(GetLocationsResponse data) => json.encode(data.toJson());

class GetLocationsResponse {
    GetLocationsResponse({
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
    List<LocationsData> data;

    factory GetLocationsResponse.fromJson(Map<String, dynamic> json) => GetLocationsResponse(
        httpStatus: json["httpStatus"],
        httpStatusCode: json["httpStatusCode"],
        success: json["success"],
        message: json["message"],
        apiName: json["apiName"],
        data: List<LocationsData>.from(json["data"].map((x) => LocationsData.fromJson(x))),
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

class LocationsData {
    LocationsData({
        required this.placeName,
        required this.placeId,
    });

    String placeName;
    String placeId;

    factory LocationsData.fromJson(Map<String, dynamic> json) => LocationsData(
        placeName: json["placeName"],
        placeId: json["placeId"],
    );

    Map<String, dynamic> toJson() => {
        "placeName": placeName,
        "placeId": placeId,
    };
}
