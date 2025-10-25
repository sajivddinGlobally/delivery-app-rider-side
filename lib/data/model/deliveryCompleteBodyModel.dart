// To parse this JSON data, do
//
//     final deliverCompleteBodyModel = deliverCompleteBodyModelFromJson(jsonString);

import 'dart:convert';

DeliverCompleteBodyModel deliverCompleteBodyModelFromJson(String str) => DeliverCompleteBodyModel.fromJson(json.decode(str));

String deliverCompleteBodyModelToJson(DeliverCompleteBodyModel data) => json.encode(data.toJson());

class DeliverCompleteBodyModel {
    String txId;
    String image;

    DeliverCompleteBodyModel({
        required this.txId,
        required this.image,
    });

    factory DeliverCompleteBodyModel.fromJson(Map<String, dynamic> json) => DeliverCompleteBodyModel(
        txId: json["txId"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "txId": txId,
        "image": image,
    };
}
