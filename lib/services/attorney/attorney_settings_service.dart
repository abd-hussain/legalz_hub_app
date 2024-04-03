import 'package:legalz_hub_app/models/https/rating_and_review_response.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:legalz_hub_app/utils/repository/http_repository.dart';
import 'package:legalz_hub_app/utils/repository/method_name_constractor.dart';

class AttorneySettingsService with Service {
  Future<RatingAndReviewResponse> getAttorneyRatingAndReviews() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.attorneyRatingAndReviews,
    );

    return RatingAndReviewResponse.fromJson(response);
  }

  Future<dynamic> respondOnReview(
      {required int id, required String responseMessage}) async {
    final response = await repository.callRequest(
      requestType: RequestType.put,
      methodName: MethodNameConstant.attorneyRespondOnReviews,
      queryParam: {"id": id, "response": responseMessage},
    );
    return response;
  }
}
