/*
import 'package:delivery_rider_app/data/model/getCityResModel.dart';
import 'package:delivery_rider_app/data/model/loginBodyModel.dart';
import 'package:delivery_rider_app/data/model/otpModelDATA.dart';
import 'package:delivery_rider_app/data/model/registerBodyModel.dart';
import 'package:delivery_rider_app/data/model/registerResModel.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../data/model/AddBodyVihileModel.dart';
import '../../data/model/AddVihicleResponseModel.dart';
import '../../data/model/DriverResponseModel.dart';
import '../../data/model/LoginResponseModel.dart';
import '../../data/model/OtpResponseLoginModel.dart';
import '../../data/model/OtpResponseResisterModel.dart';
import '../../data/model/VihicleResponseModel.dart';
import '../../data/model/driverProfileModel.dart';
import '../../data/model/saveDriverBodyModel.dart';
part 'api.state.g.dart';

@RestApi(baseUrl: "http://192.168.1.43:4567/api")

// @RestApi(baseUrl: "https://weloads.com/api")

abstract class APIStateNetwork {
  factory APIStateNetwork(Dio dio, {String baseUrl}) = _APIStateNetwork;

  @GET("/v1/driver/getVehicleType")
  Future<VihicleResponseModel> getVehicleType();



  @POST("/v1/driver/login")
  Future<LoginResponseModel> login(@Body() LoginBodyModel body);


  @GET("/v1/driver/getCityList")
  Future<GetCityResModel> fetchCity();

  @POST("/v1/driver/register")
  Future<RegisterResModel> register(@Body() RegisterBodyModel body);




  @POST("/v1/driver/registerVerify")
  Future<OtpResponseResisterModel> verifyUser(@Body() OtpBodyModel body);


  @POST("/v1/driver/verifyUser")
  Future<OtpResponseLoginModel> verifylogin(@Body() OtpBodyModel body);



  @GET("/v1/driver/getDriverProfile")
  Future<DriverProfileModel> getDriverProfile();


  @POST("/v1/driver/saveDriverDocuments")
  Future<DriverResponseModel> saveDriverDocuments(@Body() SaveDriverBodyModel body);

  @POST("/v1/driver/addNewVehicle")
  Future<AddVihivleResponseModel> addNewVehicle (@Body() AddVihicleBodyModel body);
*/

/*

  import 'package:delivery_rider_app/data/model/getCityResModel.dart';
  import 'package:delivery_rider_app/data/model/loginBodyModel.dart';
  import 'package:delivery_rider_app/data/model/otpModelDATA.dart';
  import 'package:delivery_rider_app/data/model/registerBodyModel.dart';
  import 'package:delivery_rider_app/data/model/registerResModel.dart';
  import 'package:dio/dio.dart';
  import 'package:retrofit/retrofit.dart';
  import '../../data/model/AddBodyVihileModel.dart';
  import '../../data/model/AddVihicleResponseModel.dart';
  import '../../data/model/DriverResponseModel.dart';
  import '../../data/model/LoginResponseModel.dart';
  import '../../data/model/OtpResponseLoginModel.dart';
  import '../../data/model/OtpResponseResisterModel.dart';
  import '../../data/model/VihicleResponseModel.dart';
  import '../../data/model/driverProfileModel.dart';
  import '../../data/model/saveDriverBodyModel.dart';
  import '../../data/model/DeliveryResponseModel.dart'; // Assuming this model exists or needs to be created
  part 'api.state.g.dart';

  @RestApi(baseUrl: "http://192.168.1.43:4567/api")

// @RestApi(baseUrl: "https://weloads.com/api")

  abstract class APIStateNetwork {
  factory APIStateNetwork(Dio dio, {String baseUrl}) = _APIStateNetwork;
  @GET("/v1/driver/getDeliveryById")
  Future<DeliveryResponseModel> getDeliveryById(@Query("deliveryId") String deliveryId);

  @GET("/v1/driver/getVehicleType")
  Future<VihicleResponseModel> getVehicleType();

  @POST("/v1/driver/login")
  Future<LoginResponseModel> login(@Body() LoginBodyModel body);

  @GET("/v1/driver/getCityList")
  Future<GetCityResModel> fetchCity();

  @POST("/v1/driver/register")
  Future<RegisterResModel> register(@Body() RegisterBodyModel body);

  @POST("/v1/driver/registerVerify")
  Future<OtpResponseResisterModel> verifyUser(@Body() OtpBodyModel body);

  @POST("/v1/driver/verifyUser")
  Future<OtpResponseLoginModel> verifylogin(@Body() OtpBodyModel body);

  @GET("/v1/driver/getDriverProfile")
  Future<DriverProfileModel> getDriverProfile();

  @POST("/v1/driver/saveDriverDocuments")
  Future<DriverResponseModel> saveDriverDocuments(@Body() SaveDriverBodyModel body);

  @POST("/v1/driver/addNewVehicle")
  Future<AddVihivleResponseModel> addNewVehicle (@Body() AddVihicleBodyModel body);





}
*/

import 'package:delivery_rider_app/data/model/deliveryOnGoingBodyModel.dart';
import 'package:delivery_rider_app/data/model/deliveryOnGoingResModel.dart';
import 'package:delivery_rider_app/data/model/deliveryPickedReachedBodyModel.dart';
import 'package:delivery_rider_app/data/model/deliveryPickedReachedResModel.dart';
import 'package:delivery_rider_app/data/model/getCityResModel.dart';
import 'package:delivery_rider_app/data/model/loginBodyModel.dart';
import 'package:delivery_rider_app/data/model/otpModelDATA.dart';
import 'package:delivery_rider_app/data/model/registerBodyModel.dart';
import 'package:delivery_rider_app/data/model/registerResModel.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../data/model/AddBodyVihileModel.dart';
import '../../data/model/AddVihicleResponseModel.dart';
import '../../data/model/DeliveryOnGoingModel.dart';
import '../../data/model/DriverResponseModel.dart';
import '../../data/model/LoginResponseModel.dart';
import '../../data/model/OtpResponseLoginModel.dart';
import '../../data/model/OtpResponseResisterModel.dart';
import '../../data/model/PickedModel.dart';
import '../../data/model/VihicleResponseModel.dart';
import '../../data/model/driverProfileModel.dart';
import '../../data/model/saveDriverBodyModel.dart';
import '../../data/model/DeliveryResponseModel.dart';
part 'api.state.g.dart';

@RestApi(baseUrl: "https://weloads.com/api")
// @RestApi(baseUrl: "http://192.168.1.43:4567/api")
abstract class APIStateNetwork {
  factory APIStateNetwork(Dio dio, {String baseUrl}) = _APIStateNetwork;

  // ✅ Delivery-related
  @GET("/v1/driver/getDeliveryById")
  Future<DeliveryResponseModel> getDeliveryById(
    @Query("deliveryId") String deliveryId,
  );

  @POST("/v1/driver/deliveryPickupReached")
  Future<HttpResponse<dynamic>> deliveryPickupReached(
    @Body() PickedBodyModel body,
  );

  @POST("/v1/driver/deliveryOnGoingReached")
  Future<HttpResponse<dynamic>> deliveryOnGoingReached(
    @Body() DeliveryOnGoingModel body,
  );

  // ✅ Vehicle-related
  @GET("/v1/driver/getVehicleType")
  Future<VihicleResponseModel> getVehicleType();

  @POST("/v1/driver/addNewVehicle")
  Future<AddVihivleResponseModel> addNewVehicle(
    @Body() AddVihicleBodyModel body,
  );

  // ✅ Auth-related
  @POST("/v1/driver/login")
  Future<LoginResponseModel> login(@Body() LoginBodyModel body);

  @POST("/v1/driver/register")
  Future<RegisterResModel> register(@Body() RegisterBodyModel body);

  @POST("/v1/driver/registerVerify")
  Future<OtpResponseResisterModel> verifyUser(@Body() OtpBodyModel body);

  @POST("/v1/driver/verifyUser")
  Future<OtpResponseLoginModel> verifylogin(@Body() OtpBodyModel body);

  // ✅ Profile-related
  @GET("/v1/driver/getDriverProfile")
  Future<DriverProfileModel> getDriverProfile();

  @POST("/v1/driver/saveDriverDocuments")
  Future<DriverResponseModel> saveDriverDocuments(
    @Body() SaveDriverBodyModel body,
  );

  // ✅ City List
  @GET("/v1/driver/getCityList")
  Future<GetCityResModel> fetchCity();

  @POST("/v1/driver/deliveryPickupReached")
  Future<DeliveryPickedReachedResModel> pickedOrReachedDelivery(
    @Body() DeliveryPickedReachedBodyModel body,
  );

  @POST("/v1/driver/deliveryOnGoingReached")
  Future<DeliveryOnGoingResModel> deliveryOnGoing(
    @Body() DeliveryOnGoingBodyModel body,
  );
}
