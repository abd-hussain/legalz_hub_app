import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:legalz_hub_app/models/https/rating_and_review_response.dart';
import 'package:legalz_hub_app/services/attorney/attorney_settings_service.dart';
import 'package:legalz_hub_app/utils/mixins.dart';

class RatingAndReviewBloc extends Bloc<AttorneySettingsService> {
  final ValueNotifier<List<RatingAndReviewResponseData>>
      ratingAndReviewsListNotifier =
      ValueNotifier<List<RatingAndReviewResponseData>>([]);

  final DateFormat formatter = DateFormat('yyyy/MM/dd hh:mm');

  Future<void> getRatingAndReviews() async {
    await service.getAttorneyRatingAndReviews().then((value) {
      if (value.data != null) {}
      ratingAndReviewsListNotifier.value = value.data!;
    });
  }

  Future<void> respondOnReview(
      {required int id, required String responseMessage}) async {
    await service.respondOnReview(id: id, responseMessage: responseMessage);
  }

  @override
  void onDispose() {
    ratingAndReviewsListNotifier.dispose();
  }
}
