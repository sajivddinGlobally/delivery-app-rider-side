// To parse this JSON data, do
//
//     final driverUpdateProfileImageResModel = driverUpdateProfileImageResModelFromJson(jsonString);

import 'dart:convert';

DriverUpdateProfileImageResModel driverUpdateProfileImageResModelFromJson(String str) => DriverUpdateProfileImageResModel.fromJson(json.decode(str));

String driverUpdateProfileImageResModelToJson(DriverUpdateProfileImageResModel data) => json.encode(data.toJson());

class DriverUpdateProfileImageResModel {
    String message;
    int code;
    bool error;
    dynamic data;

    DriverUpdateProfileImageResModel({
        required this.message,
        required this.code,
        required this.error,
        required this.data,
    });

    factory DriverUpdateProfileImageResModel.fromJson(Map<String, dynamic> json) => DriverUpdateProfileImageResModel(
        message: json["message"],
        code: json["code"],
        error: json["error"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
        "error": error,
        "data": data,
    };
}
