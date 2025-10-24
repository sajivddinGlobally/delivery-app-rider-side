// To parse this JSON data, do
//
//     final deliveryResponseModel = deliveryResponseModelFromJson(jsonString);

import 'dart:convert';

DeliveryResponseModel deliveryResponseModelFromJson(String str) => DeliveryResponseModel.fromJson(json.decode(str));

String deliveryResponseModelToJson(DeliveryResponseModel data) => json.encode(data.toJson());

class DeliveryResponseModel {
  String? message;
  int? code;
  bool? error;
  Data? data;

  DeliveryResponseModel({
    this.message,
    this.code,
    this.error,
    this.data,
  });

  factory DeliveryResponseModel.fromJson(Map<String, dynamic> json) => DeliveryResponseModel(
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
  Dropoff? pickup;
  Dropoff? dropoff;
  PackageDetails? packageDetails;
  String? id;
  Customer? customer;
  String? deliveryBoy;
  String? status;
  String? paymentMethod;
  int? createdAt;

  Data({
    this.pickup,
    this.dropoff,
    this.packageDetails,
    this.id,
    this.customer,
    this.deliveryBoy,
    this.status,
    this.paymentMethod,
    this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pickup: json["pickup"] == null ? null : Dropoff.fromJson(json["pickup"]),
    dropoff: json["dropoff"] == null ? null : Dropoff.fromJson(json["dropoff"]),
    packageDetails: json["packageDetails"] == null ? null : PackageDetails.fromJson(json["packageDetails"]),
    id: json["_id"],
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    deliveryBoy: json["deliveryBoy"],
    status: json["status"],
    paymentMethod: json["paymentMethod"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "pickup": pickup?.toJson(),
    "dropoff": dropoff?.toJson(),
    "packageDetails": packageDetails?.toJson(),
    "_id": id,
    "customer": customer?.toJson(),
    "deliveryBoy": deliveryBoy,
    "status": status,
    "paymentMethod": paymentMethod,
    "createdAt": createdAt,
  };
}

class Customer {
  CurrentLocation? currentLocation;
  String? id;
  String? userType;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? password;
  String? cityId;
  String? driverStatus;
  String? status;
  String? deviceId;
  int? completedOrderCount;
  int? averageRating;
  String? referralCode;
  String? refByCode;
  String? image;
  bool? isDisable;
  bool? isDeleted;
  List<VehicleDetail>? vehicleDetails;
  List<dynamic>? rating;
  int? date;
  int? month;
  int? year;
  int? createdAt;
  int? updatedAt;
  String? socketId;

  Customer({
    this.currentLocation,
    this.id,
    this.userType,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.password,
    this.cityId,
    this.driverStatus,
    this.status,
    this.deviceId,
    this.completedOrderCount,
    this.averageRating,
    this.referralCode,
    this.refByCode,
    this.image,
    this.isDisable,
    this.isDeleted,
    this.vehicleDetails,
    this.rating,
    this.date,
    this.month,
    this.year,
    this.createdAt,
    this.updatedAt,
    this.socketId,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    currentLocation: json["currentLocation"] == null ? null : CurrentLocation.fromJson(json["currentLocation"]),
    id: json["_id"],
    userType: json["userType"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    phone: json["phone"],
    password: json["password"],
    cityId: json["cityId"],
    driverStatus: json["driverStatus"],
    status: json["status"],
    deviceId: json["deviceId"],
    completedOrderCount: json["completedOrderCount"],
    averageRating: json["averageRating"],
    referralCode: json["referralCode"],
    refByCode: json["refByCode"],
    image: json["image"],
    isDisable: json["isDisable"],
    isDeleted: json["isDeleted"],
    vehicleDetails: json["vehicleDetails"] == null ? [] : List<VehicleDetail>.from(json["vehicleDetails"]!.map((x) => VehicleDetail.fromJson(x))),
    rating: json["rating"] == null ? [] : List<dynamic>.from(json["rating"]!.map((x) => x)),
    date: json["date"],
    month: json["month"],
    year: json["year"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    socketId: json["socketId"],
  );

  Map<String, dynamic> toJson() => {
    "currentLocation": currentLocation?.toJson(),
    "_id": id,
    "userType": userType,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "phone": phone,
    "password": password,
    "cityId": cityId,
    "driverStatus": driverStatus,
    "status": status,
    "deviceId": deviceId,
    "completedOrderCount": completedOrderCount,
    "averageRating": averageRating,
    "referralCode": referralCode,
    "refByCode": refByCode,
    "image": image,
    "isDisable": isDisable,
    "isDeleted": isDeleted,
    "vehicleDetails": vehicleDetails == null ? [] : List<dynamic>.from(vehicleDetails!.map((x) => x.toJson())),
    "rating": rating == null ? [] : List<dynamic>.from(rating!.map((x) => x)),
    "date": date,
    "month": month,
    "year": year,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "socketId": socketId,
  };
}

class CurrentLocation {
  String? type;
  List<double>? coordinates;

  CurrentLocation({
    this.type,
    this.coordinates,
  });

  factory CurrentLocation.fromJson(Map<String, dynamic> json) => CurrentLocation(
    type: json["type"],
    coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
  };
}

class VehicleDetail {
  String? id;
  String? vehicle;
  String? numberPlate;
  String? model;
  int? capacityWeight;
  int? capacityVolume;
  bool? isActive;
  String? status;

  VehicleDetail({
    this.id,
    this.vehicle,
    this.numberPlate,
    this.model,
    this.capacityWeight,
    this.capacityVolume,
    this.isActive,
    this.status,
  });

  factory VehicleDetail.fromJson(Map<String, dynamic> json) => VehicleDetail(
    id: json["_id"],
    vehicle: json["vehicle"],
    numberPlate: json["numberPlate"],
    model: json["model"],
    capacityWeight: json["capacityWeight"],
    capacityVolume: json["capacityVolume"],
    isActive: json["isActive"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "vehicle": vehicle,
    "numberPlate": numberPlate,
    "model": model,
    "capacityWeight": capacityWeight,
    "capacityVolume": capacityVolume,
    "isActive": isActive,
    "status": status,
  };
}

class Dropoff {
  String? name;
  double? lat;
  double? long;

  Dropoff({
    this.name,
    this.lat,
    this.long,
  });

  factory Dropoff.fromJson(Map<String, dynamic> json) => Dropoff(
    name: json["name"],
    lat: json["lat"]?.toDouble(),
    long: json["long"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "lat": lat,
    "long": long,
  };
}

class PackageDetails {
  bool? fragile;

  PackageDetails({
    this.fragile,
  });

  factory PackageDetails.fromJson(Map<String, dynamic> json) => PackageDetails(
    fragile: json["fragile"],
  );

  Map<String, dynamic> toJson() => {
    "fragile": fragile,
  };
}
