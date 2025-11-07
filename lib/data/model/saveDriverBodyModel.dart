// To parse this JSON data, do
//
//     final SaveDriverBodyModel = SaveDriverBodyModelFromJson(jsonString);

import 'dart:convert';

SaveDriverBodyModel SaveDriverBodyModelFromJson(String str) => SaveDriverBodyModel.fromJson(json.decode(str));

String SaveDriverBodyModelToJson(SaveDriverBodyModel data) => json.encode(data.toJson());

class SaveDriverBodyModel {
  String identityFront;



  SaveDriverBodyModel({
    required this.identityFront,


  });

  factory SaveDriverBodyModel.fromJson(Map<String, dynamic> json) => SaveDriverBodyModel(
    identityFront: json["identityFront"],


  );

  Map<String, dynamic> toJson() => {
    "identityFront": identityFront,


  };
}



SaveDriverBackBodyModel SaveDriverBackBodyModelFromJson(String str) => SaveDriverBackBodyModel.fromJson(json.decode(str));

String SaveDriverBackBodyModelToJson(SaveDriverBackBodyModel data) => json.encode(data.toJson());

class SaveDriverBackBodyModel {

  String identityBack;


  SaveDriverBackBodyModel({

    required this.identityBack,

  });

  factory SaveDriverBackBodyModel.fromJson(Map<String, dynamic> json) => SaveDriverBackBodyModel(

    identityBack: json["identityBack"],

  );

  Map<String, dynamic> toJson() => {

    "identityBack": identityBack,

  };
}
