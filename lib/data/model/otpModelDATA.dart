// To parse this JSON data, do
//
//     final OtpBodyModel = OtpBodyModelFromJson(jsonString);

import 'dart:convert';

OtpBodyModel OtpBodyModelFromJson(String str) => OtpBodyModel.fromJson(json.decode(str));

String OtpBodyModelToJson(OtpBodyModel data) => json.encode(data.toJson());

class OtpBodyModel {
  String token;
  String otp;


  OtpBodyModel({
    required this.token,
    required this.otp,

  });

  factory OtpBodyModel.fromJson(Map<String, dynamic> json) => OtpBodyModel(
    token: json["token"],
    otp: json["otp"],

  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "otp": otp,

  };
}
