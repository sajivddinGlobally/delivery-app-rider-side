// To parse this JSON data, do
//
//     final deliveryPickedReachedBodyModel = deliveryPickedReachedBodyModelFromJson(jsonString);

import 'dart:convert';

DeliveryPickedReachedBodyModel deliveryPickedReachedBodyModelFromJson(String str) => DeliveryPickedReachedBodyModel.fromJson(json.decode(str));

String deliveryPickedReachedBodyModelToJson(DeliveryPickedReachedBodyModel data) => json.encode(data.toJson());

class DeliveryPickedReachedBodyModel {
    String txId;

    DeliveryPickedReachedBodyModel({
        required this.txId,
    });

    factory DeliveryPickedReachedBodyModel.fromJson(Map<String, dynamic> json) => DeliveryPickedReachedBodyModel(
        txId: json["txId"],
    );

    Map<String, dynamic> toJson() => {
        "txId": txId,
    };
}
