// To parse this JSON data, do
//
//     final getTicketListBodyModel = getTicketListBodyModelFromJson(jsonString);

import 'dart:convert';

GetTicketListBodyModel getTicketListBodyModelFromJson(String str) => GetTicketListBodyModel.fromJson(json.decode(str));

String getTicketListBodyModelToJson(GetTicketListBodyModel data) => json.encode(data.toJson());

class GetTicketListBodyModel {
    String keyWord;
    int pageNo;
    int size;

    GetTicketListBodyModel({
        required this.keyWord,
        required this.pageNo,
        required this.size,
    });

    factory GetTicketListBodyModel.fromJson(Map<String, dynamic> json) => GetTicketListBodyModel(
        keyWord: json["keyWord"],
        pageNo: json["pageNo"],
        size: json["size"],
    );

    Map<String, dynamic> toJson() => {
        "keyWord": keyWord,
        "pageNo": pageNo,
        "size": size,
    };
}
