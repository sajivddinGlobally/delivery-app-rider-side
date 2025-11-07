// To parse this JSON data, do
//
//     final ratingResponseModel = ratingResponseModelFromJson(jsonString);

import 'dart:convert';

RatingResponseModel ratingResponseModelFromJson(String str) => RatingResponseModel.fromJson(json.decode(str));

String ratingResponseModelToJson(RatingResponseModel data) => json.encode(data.toJson());

class RatingResponseModel {
  String? message;
  int? code;
  bool? error;
  Data? data;

  RatingResponseModel({
    this.message,
    this.code,
    this.error,
    this.data,
  });

  factory RatingResponseModel.fromJson(Map<String, dynamic> json) => RatingResponseModel(
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
  int? total;
  List<ListElement>? list;

  Data({
    this.total,
    this.list,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    total: json["total"],
    list: json["list"] == null ? [] : List<ListElement>.from(json["list"]!.map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "list": list == null ? [] : List<dynamic>.from(list!.map((x) => x.toJson())),
  };
}

class ListElement {
  String? id;
  String? driverId;
  UserId? userId;
  int? v;
  String? comment;
  int? createdAt;
  int? date;
  bool? isDeleted;
  bool? isDisable;
  int? month;
  int? rating;
  int? updatedAt;
  int? year;

  ListElement({
    this.id,
    this.driverId,
    this.userId,
    this.v,
    this.comment,
    this.createdAt,
    this.date,
    this.isDeleted,
    this.isDisable,
    this.month,
    this.rating,
    this.updatedAt,
    this.year,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["_id"],
    driverId: json["driverId"],
    userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
    v: json["__v"],
    comment: json["comment"],
    createdAt: json["createdAt"],
    date: json["date"],
    isDeleted: json["isDeleted"],
    isDisable: json["isDisable"],
    month: json["month"],
    rating: json["rating"],
    updatedAt: json["updatedAt"],
    year: json["year"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "driverId": driverId,
    "userId": userId?.toJson(),
    "__v": v,
    "comment": comment,
    "createdAt": createdAt,
    "date": date,
    "isDeleted": isDeleted,
    "isDisable": isDisable,
    "month": month,
    "rating": rating,
    "updatedAt": updatedAt,
    "year": year,
  };
}

class UserId {
  String? id;
  String? firstName;
  String? lastName;
  dynamic image;

  UserId({
    this.id,
    this.firstName,
    this.lastName,
    this.image,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "image": image,
  };
}
