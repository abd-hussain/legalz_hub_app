import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/error/exceptions.dart';
import 'package:legalz_hub_app/utils/logger.dart';
import 'package:legalz_hub_app/utils/mixins.dart';

class HttpInterceptor extends InterceptorsWrapper {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final box = Hive.box(DatabaseBoxConstant.userInfo);
    if (box.get(DatabaseFieldConstant.token) != null ||
        box.get(DatabaseFieldConstant.token) != "") {
      final String bearerToken =
          "Bearer ${box.get(DatabaseFieldConstant.token)}";
      options.headers = {
        "Authorization": bearerToken,
        "lang": box.get(DatabaseFieldConstant.language),
      };
    } else {
      options.headers
          .putIfAbsent("lang", () => box.get(DatabaseFieldConstant.language));
    }
    return handler.next(options);
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    try {
      if (await validateResponse(response)) {
        return handler.next(response);
      }
    } catch (error) {
      handler.reject(error as DioException);
    }
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    return super.onError(err, handler);
  }

  Future<bool> validateResponse<T extends Model, TR>(Response response) async {
    debugPrint(
        "request name ${response.requestOptions.path} -- status code ${response.statusCode}");

    switch (response.statusCode) {
      case 200:
      case 201:
        return true;
      case 403:
      case 404:
        logErrorMessageCrashlytics(
          error: response.statusCode,
          message: "response.data ${response.data}",
        );

        throw DioException(
            error: HttpException(
                status: response.statusCode!,
                message: response.data["detail"] ?? response.data.toString(),
                requestId: ""),
            requestOptions: response.requestOptions);

      case 500:
        throw DioException(
            error: HttpException(
                status: response.statusCode!,
                message: "Server Down",
                requestId: ""),
            requestOptions: response.requestOptions);
      default:
        logErrorMessageCrashlytics(
          error: response.statusCode,
          message: "response.data ${response.data}",
        );

        throw DioException(
            error: HttpException(
                status: response.statusCode!,
                message: response.data["detail"]["message"],
                requestId: response.data["detail"]["request_id"]),
            requestOptions: response.requestOptions);
    }
  }
}
