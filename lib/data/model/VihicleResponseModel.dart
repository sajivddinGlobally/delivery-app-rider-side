// To parse this JSON data, do
//
//     final vihicleResponseModel = vihicleResponseModelFromJson(jsonString);

import 'dart:convert';

VihicleResponseModel vihicleResponseModelFromJson(String str) => VihicleResponseModel.fromJson(json.decode(str));

String vihicleResponseModelToJson(VihicleResponseModel data) => json.encode(data.toJson());

class VihicleResponseModel {
  String? message;
  int? code;
  bool? error;
  List<Datum>? data;

  VihicleResponseModel({
    this.message,
    this.code,
    this.error,
    this.data,
  });

  factory VihicleResponseModel.fromJson(Map<String, dynamic> json) => VihicleResponseModel(
    message: json["message"],
    code: json["code"],
    error: json["error"],
    data: json["data"] == null ? <Datum>[] : (json["data"] as List<dynamic>).map((x) => Datum.fromJson(x as Map<String, dynamic>)).toList(),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "error": error,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? name;
  int? capacity;
  int? baseFare;
  int? perKmRate;
  double? perMinuteRate;
  int? maxDeliveryDistance;
  String? image;
  bool? isDisable;
  bool? isDeleted;
  int? date;
  int? month;
  int? year;
  int? createdAt;
  int? updatedAt;
  int? v;

  Datum({
    this.id,
    this.name,
    this.capacity,
    this.baseFare,
    this.perKmRate,
    this.perMinuteRate,
    this.maxDeliveryDistance,
    this.image,
    this.isDisable,
    this.isDeleted,
    this.date,
    this.month,
    this.year,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    name: json["name"],
    capacity: json["capacity"],
    baseFare: json["baseFare"],
    perKmRate: json["perKmRate"],
    perMinuteRate: json["perMinuteRate"]?.toDouble(),
    maxDeliveryDistance: json["maxDeliveryDistance"],
    image: json["image"],
    isDisable: json["isDisable"],
    isDeleted: json["isDeleted"],
    date: json["date"],
    month: json["month"],
    year: json["year"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "capacity": capacity,
    "baseFare": baseFare,
    "perKmRate": perKmRate,
    "perMinuteRate": perMinuteRate,
    "maxDeliveryDistance": maxDeliveryDistance,
    "image": image,
    "isDisable": isDisable,
    "isDeleted": isDeleted,
    "date": date,
    "month": month,
    "year": year,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
  };
}