// To parse this JSON data, do
//
//     final imageBodyModel = imageBodyModelFromJson(jsonString);

import 'dart:convert';

ImageBodyModel imageBodyModelFromJson(String str) =>
    ImageBodyModel.fromJson(json.decode(str));

String imageBodyModelToJson(ImageBodyModel data) =>
    json.encode(data.toJson());

class ImageBodyModel {
  // final String firstName;
  // final String lastName;
  // final String cityId;
  // final String email;
  final String image;

  ImageBodyModel({
    // required this.firstName,
    // required this.lastName,
    // required this.cityId,
    // required this.email,
    required this.image,
  });

  factory ImageBodyModel.fromJson(Map<String, dynamic> json) => ImageBodyModel(
    // firstName: json["firstName"] as String,
    // lastName: json["lastName"] as String,
    // cityId: json["cityId"] as String,
    // email: json["email"] as String,
    image: json["image"] as String,
  );

  Map<String, dynamic> toJson() => {
    // "firstName": firstName,
    // "lastName": lastName,
    // "cityId": cityId,
    // "email": email,
    "image": image,
  };
}