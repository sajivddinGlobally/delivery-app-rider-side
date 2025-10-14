import 'package:delivery_rider_app/config/network/api.state.dart';
import 'package:delivery_rider_app/config/utils/pretty.dio.dart';
import 'package:delivery_rider_app/data/model/getCityResModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getCityControlelr = FutureProvider<GetCityResModel>((ref) async {
  final service = APIStateNetwork(callDio());
  return await service.fetchCity();
});
