import 'package:delivery_rider_app/data/model/getCityResModel.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'api.state.g.dart';

@RestApi(baseUrl: "http://192.168.1.43:4567/api")
abstract class APIStateNetwork {
  factory APIStateNetwork(Dio dio, {String baseUrl}) = _ApiStateNetwork;

  @GET("/v1/driver/getCityList")
  Future<GetCityResModel> fetchCity();
}
