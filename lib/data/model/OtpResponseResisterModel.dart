// To parse this JSON data, do
//
//     final otpResponseResisterModel = otpResponseResisterModelFromJson(jsonString);

import 'dart:convert';

OtpResponseResisterModel otpResponseResisterModelFromJson(String str) => OtpResponseResisterModel.fromJson(json.decode(str));

String otpResponseResisterModelToJson(OtpResponseResisterModel data) => json.encode(data.toJson());

class OtpResponseResisterModel {
  String? message;
  int? code;
  bool? error;
  Data? data;

  OtpResponseResisterModel({
    this.message,
    this.code,
    this.error,
    this.data,
  });

  factory OtpResponseResisterModel.fromJson(Map<String, dynamic> json) => OtpResponseResisterModel(
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
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? id;

  Data({
    this.token,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    phone: json["phone"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phone": phone,
    "id": id,
  };
}
