// To parse this JSON data, do
//
//     final PickedBodyModel = PickedBodyModelFromJson(jsonString);

import 'dart:convert';

PickedBodyModel PickedBodyModelFromJson(String str) => PickedBodyModel.fromJson(json.decode(str));

String PickedBodyModelToJson(PickedBodyModel data) => json.encode(data.toJson());

class PickedBodyModel {
  String txId;
  


  PickedBodyModel({
    required this.txId,
    

  });

  factory PickedBodyModel.fromJson(Map<String, dynamic> json) => PickedBodyModel(
    txId: json["txId"],
    

  );

  Map<String, dynamic> toJson() => {
    "txId": txId,
    

  };
}
