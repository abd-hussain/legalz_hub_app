import 'package:legalz_hub_app/locator.dart';

import 'repository/http_repository.dart';

abstract class Bloc<T extends Object> {
  onDispose();

  final service = locator<T>();
}

mixin Service {
  final repository = locator<HttpRepository>();
}

abstract class Model<T> {
  Map<String, dynamic> toJson();
  Model();
}
