// To parse this JSON data, do
//
//     final deliveryOnGoingResModel = deliveryOnGoingResModelFromJson(jsonString);

import 'dart:convert';

DeliveryOnGoingResModel deliveryOnGoingResModelFromJson(String str) =>
    DeliveryOnGoingResModel.fromJson(json.decode(str));

String deliveryOnGoingResModelToJson(DeliveryOnGoingResModel data) =>
    json.encode(data.toJson());

class DeliveryOnGoingResModel {
  String message;
  int code;
  bool error;
  String? data;

  DeliveryOnGoingResModel({
    required this.message,
    required this.code,
    required this.error,
    this.data,
  });

  factory DeliveryOnGoingResModel.fromJson(Map<String, dynamic> json) =>
      DeliveryOnGoingResModel(
        message: json["message"],
        code: json["code"],
        error: json["error"],
        data: json["data"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "error": error,
    "data": data,
  };
}
