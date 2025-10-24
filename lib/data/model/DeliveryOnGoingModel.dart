


// To parse this JSON data, do
//
//     final DeliveryOnGoingModel = DeliveryOnGoingModelFromJson(jsonString);

import 'dart:convert';

DeliveryOnGoingModel DeliveryOnGoingModelFromJson(String str) => DeliveryOnGoingModel.fromJson(json.decode(str));

String DeliveryOnGoingModelToJson(DeliveryOnGoingModel data) => json.encode(data.toJson());

class DeliveryOnGoingModel {
  String txId;
  String otp;



  DeliveryOnGoingModel({
    required this.txId,
    required this.otp,


  });

  factory DeliveryOnGoingModel.fromJson(Map<String, dynamic> json) => DeliveryOnGoingModel(
    txId: json["txId"],
    otp: json["otp"],


  );

  Map<String, dynamic> toJson() => {
    "txId": txId,
    "otp": otp,


  };
}
