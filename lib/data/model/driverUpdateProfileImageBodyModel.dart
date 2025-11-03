// // // To parse this JSON data, do
// // //
// //     final driverUpdateProfileImageBodyModel = driverUpdateProfileImageBodyModelFromJson(jsonString);

// import 'dart:convert';

// DriverUpdateProfileImageBodyModel driverUpdateProfileImageBodyModelFromJson(String str) => DriverUpdateProfileImageBodyModel.fromJson(json.decode(str));

// String driverUpdateProfileImageBodyModelToJson(DriverUpdateProfileImageBodyModel data) => json.encode(data.toJson());

// class DriverUpdateProfileImageBodyModel {
//     String image;

//     DriverUpdateProfileImageBodyModel({
//         required this.image,
//     });

//     factory DriverUpdateProfileImageBodyModel.fromJson(Map<String, dynamic> json) => DriverUpdateProfileImageBodyModel(
//         image: json["image"],
//     );

//     Map<String, dynamic> toJson() => {
//         "image": image,
//     };
// }


import 'package:dio/dio.dart';

class DriverUpdateProfileImageBodyModel {
  final MultipartFile image;

  DriverUpdateProfileImageBodyModel({required this.image});

  FormData toFormData() => FormData.fromMap({
        'image': image,
      });
}
