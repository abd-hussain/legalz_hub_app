import 'package:legalz_hub_app/models/https/hour_rate_response.dart';
import 'package:legalz_hub_app/models/https/rating_and_review_response.dart';
import 'package:legalz_hub_app/models/https/update_password_request.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:legalz_hub_app/utils/repository/http_repository.dart';
import 'package:legalz_hub_app/utils/repository/method_name_constractor.dart';

class MentorSettingsService with Service {
  Future<HourRateResponse> getHourRate() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.mentorHourRate,
    );

    return HourRateResponse.fromJson(response);
  }

  Future<dynamic> updateHourRate(
      {required String newRate,
      required String iban,
      required int freeCall}) async {
    final response = await repository.callRequest(
      requestType: RequestType.put,
      queryParam: {
        "hour_rate": newRate,
        "iban": iban,
        "free_type": freeCall,
      },
      methodName: MethodNameConstant.mentorHourRate,
    );

    return response;
  }

  Future<dynamic> removeAccount() async {
    final response = await repository.callRequest(
      requestType: RequestType.delete,
      methodName: MethodNameConstant.deleteAccount,
    );
    return response;
  }

  Future<dynamic> changePassword(
      {required UpdatePasswordRequest account}) async {
    final response = await repository.callRequest(
      requestType: RequestType.put,
      methodName: MethodNameConstant.changePassword,
      postBody: account,
    );
    return response;
  }

  Future<RatingAndReviewResponse> getMentorRatingAndReviews() async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.mentorRatingAndReviews,
    );

    return RatingAndReviewResponse.fromJson(response);
  }

  Future<dynamic> respondOnReview(
      {required int id, required String responseMessage}) async {
    final response = await repository.callRequest(
      requestType: RequestType.put,
      methodName: MethodNameConstant.mentorRespondOnReviews,
      queryParam: {"id": id, "response": responseMessage},
    );
    return response;
  }
}
