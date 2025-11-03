// To parse this JSON data, do
//
//     final rejectedDeliveryResponseModel = rejectedDeliveryResponseModelFromJson(jsonString);

import 'dart:convert';

RejectedDeliveryResponseModel rejectedDeliveryResponseModelFromJson(String str) => RejectedDeliveryResponseModel.fromJson(json.decode(str));

String rejectedDeliveryResponseModelToJson(RejectedDeliveryResponseModel data) => json.encode(data.toJson());

class RejectedDeliveryResponseModel {
  String? message;
  int? code;
  bool? error;
  dynamic data;

  RejectedDeliveryResponseModel({
    this.message,
    this.code,
    this.error,
    this.data,
  });

  factory RejectedDeliveryResponseModel.fromJson(Map<String, dynamic> json) => RejectedDeliveryResponseModel(
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
