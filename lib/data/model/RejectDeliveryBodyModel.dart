// To parse this JSON data, do
//
//     final RejectDeliveryBodyModel = RejectDeliveryBodyModelFromJson(jsonString);

import 'dart:convert';

RejectDeliveryBodyModel RejectDeliveryBodyModelFromJson(String str) => RejectDeliveryBodyModel.fromJson(json.decode(str));

String RejectDeliveryBodyModelToJson(RejectDeliveryBodyModel data) => json.encode(data.toJson());

class RejectDeliveryBodyModel {
  String deliveryId;
  String lat;
  String lon;


  RejectDeliveryBodyModel({
    required this.deliveryId,
    required this.lat,
    required this.lon,

  });

  factory RejectDeliveryBodyModel.fromJson(Map<String, dynamic> json) => RejectDeliveryBodyModel(
    deliveryId: json["deliveryId"],
    lat: json["lat"],
    lon: json["lon"],

  );

  Map<String, dynamic> toJson() => {
    "deliveryId": deliveryId,
    "lat": lat,
    "lon": lon,

  };
}