// To parse this JSON data, do
//
//     final deliveryPickedReachedResModel = deliveryPickedReachedResModelFromJson(jsonString);

import 'dart:convert';

DeliveryPickedReachedResModel deliveryPickedReachedResModelFromJson(
  String str,
) => DeliveryPickedReachedResModel.fromJson(json.decode(str));

String deliveryPickedReachedResModelToJson(
  DeliveryPickedReachedResModel data,
) => json.encode(data.toJson());

class DeliveryPickedReachedResModel {
  String message;
  int code;
  bool error;
  String? data;

  DeliveryPickedReachedResModel({
    required this.message,
    required this.code,
    required this.error,
    this.data,
  });

  factory DeliveryPickedReachedResModel.fromJson(Map<String, dynamic> json) =>
      DeliveryPickedReachedResModel(
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
