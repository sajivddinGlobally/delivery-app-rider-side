import 'package:delivery_rider_app/data/model/getCityResModel.dart';
import 'package:delivery_rider_app/data/model/loginBodyModel.dart';
import 'package:delivery_rider_app/data/model/otpModelDATA.dart';
import 'package:delivery_rider_app/data/model/registerBodyModel.dart';
import 'package:delivery_rider_app/data/model/registerResModel.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'api.state.g.dart';

// @RestApi(baseUrl: "http://192.168.1.43:4567/api")
@RestApi(baseUrl: "https://weloads.com/api")
abstract class APIStateNetwork {
  factory APIStateNetwork(Dio dio, {String baseUrl}) = _APIStateNetwork;

  @GET("/v1/driver/getCityList")
  Future<GetCityResModel> fetchCity();

  @POST("/v1/driver/register")
  Future<RegisterResModel> register(@Body() RegisterBodyModel body);


  @POST("/v1/driver/login")
  Future<HttpResponse<dynamic>> login(@Body() LoginBodyModel body);


  @POST("/v1/driver/registerVerify")
  Future<HttpResponse<dynamic>> verifyUser(@Body() OtpBodyModel body);


}
