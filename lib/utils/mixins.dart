import 'package:legalz_hub_app/locator.dart';

import 'package:legalz_hub_app/utils/repository/http_repository.dart';

abstract class Bloc<T extends Object> {
  void onDispose();

  final service = locator<T>();
}

mixin Service {
  final repository = locator<HttpRepository>();
}

abstract class Model<T> {
  Model();
  Map<String, dynamic> toJson();
}
