import 'package:delivery_rider_app/config/network/api.state.dart';
import 'package:delivery_rider_app/config/utils/pretty.dio.dart';
import 'package:delivery_rider_app/data/model/driverProfileModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileController = FutureProvider.autoDispose<DriverProfileModel>((
  ref,
) async {
  final service = APIStateNetwork(callDio());
  return await service.getDriverProfile();
});
