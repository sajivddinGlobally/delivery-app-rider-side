// To parse this JSON data, do
//
//     final ReviewRatingRatingModel = ReviewRatingRatingModelFromJson(jsonString);

import 'dart:convert';

ReviewRatingRatingModel ReviewRatingRatingModelFromJson(String str) => ReviewRatingRatingModel.fromJson(json.decode(str));

String ReviewRatingRatingModelToJson(ReviewRatingRatingModel data) => json.encode(data.toJson());

class ReviewRatingRatingModel {
  int? pageNo;
  int? size;


  ReviewRatingRatingModel({
    this.pageNo,
    this.size,

  });

  factory ReviewRatingRatingModel.fromJson(Map<String, dynamic> json) => ReviewRatingRatingModel(
    pageNo: json["pageNo"],
    size: json["size"],

  );

  Map<String, dynamic> toJson() => {
    "pageNo": pageNo,
    "size": size,

  };
}
