import 'dart:convert';

DriverProfileModel driverProfileModelFromJson(String str) =>
    DriverProfileModel.fromJson(json.decode(str));
String driverProfileModelToJson(DriverProfileModel data) =>
    json.encode(data.toJson());

class DriverProfileModel {
  String? message;
  int? code;
  bool? error;
  Data? data;

  DriverProfileModel({this.message, this.code, this.error, this.data});

  factory DriverProfileModel.fromJson(Map<String, dynamic> json) =>
      DriverProfileModel(
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
  String? id;
  String? userType;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? driverStatus;
  String? status;
  int? completedOrderCount;
  String? referralCode;
  String? image;
  List<VehicleDetail>? vehicleDetails;
  int? createdAt;
  Wallet? wallet;
  DriverDocuments? driverDocuments;

  Data({
    this.id,
    this.userType,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.driverStatus,
    this.status,
    this.completedOrderCount,
    this.referralCode,
    this.image,
    this.vehicleDetails,
    this.createdAt,
    this.wallet,
    this.driverDocuments,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    userType: json["userType"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    phone: json["phone"],
    driverStatus: json["driverStatus"],
    status: json["status"],
    completedOrderCount: json["completedOrderCount"],
    referralCode: json["referralCode"],
    image: json["image"],
    vehicleDetails: json["vehicleDetails"] == null
        ? []
        : List<VehicleDetail>.from(
            json["vehicleDetails"]!.map((x) => VehicleDetail.fromJson(x)),
          ),
    createdAt: json["createdAt"],
    wallet: json["wallet"] == null ? null : Wallet.fromJson(json["wallet"]),
    driverDocuments: json["driverDocuments"] == null
        ? null
        : DriverDocuments.fromJson(json["driverDocuments"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userType": userType,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phone": phone,
    "driverStatus": driverStatus,
    "status": status,
    "completedOrderCount": completedOrderCount,
    "referralCode": referralCode,
    "image": image,
    "vehicleDetails": vehicleDetails == null
        ? []
        : List<dynamic>.from(vehicleDetails!.map((x) => x.toJson())),
    "createdAt": createdAt,
    "wallet": wallet?.toJson(),
    "driverDocuments": driverDocuments?.toJson(),
  };
}

class DriverDocuments {
  Identity? identityFront;
  Identity? identityBack;

  DriverDocuments({this.identityFront, this.identityBack});

  factory DriverDocuments.fromJson(Map<String, dynamic> json) =>
      DriverDocuments(
        identityFront: json["identityFront"] == null
            ? null
            : Identity.fromJson(json["identityFront"]),
        identityBack: json["identityBack"] == null
            ? null
            : Identity.fromJson(json["identityBack"]),
      );

  Map<String, dynamic> toJson() => {
    "identityFront": identityFront?.toJson(),
    "identityBack": identityBack?.toJson(),
  };
}

class Identity {
  String? status;
  String? image;

  Identity({this.status, this.image});

  factory Identity.fromJson(Map<String, dynamic> json) =>
      Identity(status: json["status"], image: json["image"]);

  Map<String, dynamic> toJson() => {"status": status, "image": image};
}

class VehicleDetail {
  Vehicle? vehicle;
  String? numberPlate;
  String? model;
  int? capacityWeight;
  int? capacityVolume;
  bool? isActive;
  String? status;
  String? id;

  VehicleDetail({
    this.vehicle,
    this.numberPlate,
    this.model,
    this.capacityWeight,
    this.capacityVolume,
    this.isActive,
    this.status,
    this.id,
  });

  factory VehicleDetail.fromJson(Map<String, dynamic> json) => VehicleDetail(
    vehicle: json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
    numberPlate: json["numberPlate"],
    model: json["model"],
    capacityWeight: json["capacityWeight"],
    capacityVolume: json["capacityVolume"],
    isActive: json["isActive"],
    status: json["status"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "vehicle": vehicle?.toJson(),
    "numberPlate": numberPlate,
    "model": model,
    "capacityWeight": capacityWeight,
    "capacityVolume": capacityVolume,
    "isActive": isActive,
    "status": status,
    "_id": id,
  };
}

class Vehicle {
  String? id;
  String? name;
  String? image;

  Vehicle({this.id, this.name, this.image});

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      Vehicle(id: json["_id"], name: json["name"], image: json["image"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "image": image};
}

class Wallet {
  int? balance;

  Wallet({this.balance});

  factory Wallet.fromJson(Map<String, dynamic> json) =>
      Wallet(balance: json["balance"]);

  Map<String, dynamic> toJson() => {"balance": balance};
}
