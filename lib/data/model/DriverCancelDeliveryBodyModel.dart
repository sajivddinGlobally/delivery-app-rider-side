// To parse this JSON data, do
//
//     final driverCancelDeliveryBodyModel = driverCancelDeliveryBodyModelFromJson(jsonString);

import 'dart:convert';

DriverCancelDeliveryBodyModel driverCancelDeliveryBodyModelFromJson(String str) => DriverCancelDeliveryBodyModel.fromJson(json.decode(str));

String driverCancelDeliveryBodyModelToJson(DriverCancelDeliveryBodyModel data) => json.encode(data.toJson());

class DriverCancelDeliveryBodyModel {
  String txId;
  String cancellationReason;

  DriverCancelDeliveryBodyModel({
    required this.txId,
    required this.cancellationReason,
  });

  factory DriverCancelDeliveryBodyModel.fromJson(Map<String, dynamic> json) => DriverCancelDeliveryBodyModel(
    txId: json["txId"],
    cancellationReason: json["cancellationReason"],
  );

  Map<String, dynamic> toJson() => {
    "txId": txId,
    "cancellationReason": cancellationReason,
  };
}