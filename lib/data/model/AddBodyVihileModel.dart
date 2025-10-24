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
