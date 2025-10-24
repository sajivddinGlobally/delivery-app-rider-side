// To parse this JSON data, do
//
//     final SaveDriverBodyModel = SaveDriverBodyModelFromJson(jsonString);

import 'dart:convert';

SaveDriverBodyModel SaveDriverBodyModelFromJson(String str) => SaveDriverBodyModel.fromJson(json.decode(str));

String SaveDriverBodyModelToJson(SaveDriverBodyModel data) => json.encode(data.toJson());

class SaveDriverBodyModel {
  String identityFront;
  String identityBack;


  SaveDriverBodyModel({
    required this.identityFront,
    required this.identityBack,

  });

  factory SaveDriverBodyModel.fromJson(Map<String, dynamic> json) => SaveDriverBodyModel(
    identityFront: json["identityFront"],
    identityBack: json["identityBack"],

  );

  Map<String, dynamic> toJson() => {
    "identityFront": identityFront,
    "identityBack": identityBack,

  };
}
