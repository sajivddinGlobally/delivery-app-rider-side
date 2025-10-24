// To parse this JSON data, do
//
//     final addVihivleResponseModel = addVihivleResponseModelFromJson(jsonString);

import 'dart:convert';

AddVihivleResponseModel addVihivleResponseModelFromJson(String str) => AddVihivleResponseModel.fromJson(json.decode(str));

String addVihivleResponseModelToJson(AddVihivleResponseModel data) => json.encode(data.toJson());

class AddVihivleResponseModel {
  String? message;
  int? code;
  bool? error;
  dynamic data;

  AddVihivleResponseModel({
    this.message,
    this.code,
    this.error,
    this.data,
  });

  factory AddVihivleResponseModel.fromJson(Map<String, dynamic> json) => AddVihivleResponseModel(
    message: json["message"],
    code: json["code"],
    error: json["error"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "error": error,
    "data": data,
  };
}
