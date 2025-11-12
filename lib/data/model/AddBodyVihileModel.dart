/*
import 'dart:convert';

// To parse JSON string into AddVihicleBodyModel
AddVihicleBodyModel addVihicleBodyModelFromJson(String str) =>
    AddVihicleBodyModel.fromJson(json.decode(str));

// To convert AddVihicleBodyModel to JSON string
String addVihicleBodyModelToJson(AddVihicleBodyModel data) =>
    json.encode(data.toJson());

class AddVihicleBodyModel {
  String vehicle;
  String numberPlate;
  String model;
  int capacityWeight;
  int capacityVolume;

  AddVihicleBodyModel({
    required this.vehicle,
    required this.numberPlate,
    required this.model,
    required this.capacityWeight,
    required this.capacityVolume,
  });

  factory AddVihicleBodyModel.fromJson(Map<String, dynamic> json) =>
      AddVihicleBodyModel(
        vehicle: json["vehicle"],
        numberPlate: json["numberPlate"],
        model: json["model"],
        capacityWeight: json["capacityWeight"],
        capacityVolume: json["capacityVolume"],
      );

  Map<String, dynamic> toJson() => {
    "vehicle": vehicle,
    "numberPlate": numberPlate,
    "model": model,
    "capacityWeight": capacityWeight,
    "capacityVolume": capacityVolume,
  };
}
*/


import 'dart:convert';

AddVihicleBodyModel addVihicleBodyModelFromJson(String str) =>
    AddVihicleBodyModel.fromJson(json.decode(str));

String addVihicleBodyModelToJson(AddVihicleBodyModel data) =>
    json.encode(data.toJson());

class AddVihicleBodyModel {
  String vehicle;
  String numberPlate;
  String model;
  dynamic capacityWeight;  // ab dynamic ya int/string dono chalega
  dynamic capacityVolume;
  List<VehicleDocument> documents;

  AddVihicleBodyModel({
    required this.vehicle,
    required this.numberPlate,
    required this.model,
    required this.capacityWeight,
    required this.capacityVolume,
    required this.documents,
  });

  factory AddVihicleBodyModel.fromJson(Map<String, dynamic> json) =>
      AddVihicleBodyModel(
        vehicle: json["vehicle"] as String,
        numberPlate: json["numberPlate"] as String,
        model: json["model"] as String,
        capacityWeight: json["capacityWeight"],
        capacityVolume: json["capacityVolume"],
        documents: (json["documents"] as List)
            .map((e) => VehicleDocument.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    "vehicle": vehicle,
    "numberPlate": numberPlate,
    "model": model,
    "capacityWeight": capacityWeight,
    "capacityVolume": capacityVolume,
    "documents": documents.map((e) => e.toJson()).toList(),
  };
}

class VehicleDocument {
  String type;
  String fileUrl;

  VehicleDocument({
    required this.type,
    required this.fileUrl,
  });

  factory VehicleDocument.fromJson(Map<String, dynamic> json) =>
      VehicleDocument(
        type: json["type"] as String,
        fileUrl: json["fileUrl"] as String,
      );

  Map<String, dynamic> toJson() => {
    "type": type,
    "fileUrl": fileUrl,
  };
}