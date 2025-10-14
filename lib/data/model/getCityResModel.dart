// To parse this JSON data, do
//
//     final getCityResModel = getCityResModelFromJson(jsonString);

import 'dart:convert';

GetCityResModel getCityResModelFromJson(String str) =>
    GetCityResModel.fromJson(json.decode(str));

String getCityResModelToJson(GetCityResModel data) =>
    json.encode(data.toJson());

class GetCityResModel {
  String message;
  int code;
  bool error;
  List<Datum> data;

  GetCityResModel({
    required this.message,
    required this.code,
    required this.error,
    required this.data,
  });

  factory GetCityResModel.fromJson(Map<String, dynamic> json) =>
      GetCityResModel(
        message: json["message"],
        code: json["code"],
        error: json["error"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "error": error,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String city;

  Datum({required this.id, required this.city});

  factory Datum.fromJson(Map<String, dynamic> json) =>
      Datum(id: json["id"].toString(), city: json["city"]);

  Map<String, dynamic> toJson() => {"id": id, "city": city};
}
