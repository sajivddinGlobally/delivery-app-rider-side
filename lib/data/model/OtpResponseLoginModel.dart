// To parse this JSON data, do
//
//     final OtpResponseLoginModel = OtpResponseLoginModelFromJson(jsonString);

import 'dart:convert';

OtpResponseLoginModel OtpResponseLoginModelFromJson(String str) => OtpResponseLoginModel.fromJson(json.decode(str));

String OtpResponseLoginModelToJson(OtpResponseLoginModel data) => json.encode(data.toJson());

class OtpResponseLoginModel {
  String? message;
  int? code;
  bool? error;
  Data? data;

  OtpResponseLoginModel({
    this.message,
    this.code,
    this.error,
    this.data,
  });

  factory OtpResponseLoginModel.fromJson(Map<String, dynamic> json) => OtpResponseLoginModel(
    message: json["message"],
    code: json["code"],
    error: json["error"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "error": error,
    "data": data?.toJson(),
  };
}

class Data {
  String? token;

  Data({
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}
