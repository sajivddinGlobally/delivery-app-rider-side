
import 'dart:io';

import 'package:delivery_rider_app/data/model/ReviewRatingRequest.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/network/api.state.dart';
import '../../config/utils/pretty.dio.dart';
import '../../data/model/RatingResponseModel.dart';

final ratingProvider = FutureProvider.autoDispose<RatingResponseModel>((ref) async {
  final service = APIStateNetwork(callDio());

  final request = ReviewRatingRatingModel(pageNo: 1, size: 100);
  final response = await service.getReviewRatingList(request);

  if (response.code == 0  && response.data != null) {
    return response!;
  } else {
    throw Exception(response.message ?? "Failed to load ratings");
  }
});



