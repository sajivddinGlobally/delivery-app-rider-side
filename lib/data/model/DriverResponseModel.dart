// To parse this JSON data, do
//
//     final driverResponseModel = driverResponseModelFromJson(jsonString);

import 'dart:convert';

DriverResponseModel driverResponseModelFromJson(String str) => DriverResponseModel.fromJson(json.decode(str));

String driverResponseModelToJson(DriverResponseModel data) => json.encode(data.toJson());

class DriverResponseModel {
  String? message;
  int? code;
  bool? error;
  dynamic data;

  DriverResponseModel({
    this.message,
    this.code,
    this.error,
    this.data,
  });

  factory DriverResponseModel.fromJson(Map<String, dynamic> json) => DriverResponseModel(
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
