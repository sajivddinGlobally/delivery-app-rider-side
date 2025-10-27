// To parse this JSON data, do
//
//     final deliveryHistoryRequestModel = DeliveryHistoryRequestModelFromJson(jsonString);

import 'dart:convert';

DeliveryHistoryRequestModel DeliveryHistoryRequestModelFromJson(String str) => DeliveryHistoryRequestModel.fromJson(json.decode(str));

String DeliveryHistoryRequestModelToJson(DeliveryHistoryRequestModel data) => json.encode(data.toJson());

class DeliveryHistoryRequestModel {
  int page;
  int limit;
  String key;

  DeliveryHistoryRequestModel({
    required this.page,
    required this.limit,
    required this.key,
  });

  factory DeliveryHistoryRequestModel.fromJson(Map<String, dynamic> json) => DeliveryHistoryRequestModel(
    page: json["page"],
    limit: json["limit"],
    key: json["key"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "key": key,
  };
}