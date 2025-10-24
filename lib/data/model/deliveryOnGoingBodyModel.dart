// To parse this JSON data, do
//
//     final deliveryOnGoingBodyModel = deliveryOnGoingBodyModelFromJson(jsonString);

import 'dart:convert';

DeliveryOnGoingBodyModel deliveryOnGoingBodyModelFromJson(String str) => DeliveryOnGoingBodyModel.fromJson(json.decode(str));

String deliveryOnGoingBodyModelToJson(DeliveryOnGoingBodyModel data) => json.encode(data.toJson());

class DeliveryOnGoingBodyModel {
    String txId;
    String otp;

    DeliveryOnGoingBodyModel({
        required this.txId,
        required this.otp,
    });

    factory DeliveryOnGoingBodyModel.fromJson(Map<String, dynamic> json) => DeliveryOnGoingBodyModel(
        txId: json["txId"],
        otp: json["otp"],
    );

    Map<String, dynamic> toJson() => {
        "txId": txId,
        "otp": otp,
    };
}
