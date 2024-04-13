import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/services/home_services.dart';
import 'package:legalz_hub_app/services/noticitions_services.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/mixins.dart';

class HomeBloc extends Bloc<HomeService> {
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  UserType userType = UserType.customer;

  void callRegisterTokenRequest() async {
    final String token = box.get(DatabaseFieldConstant.pushNotificationToken);
    await locator<NotificationsService>().registerToken(token, userType);
  }

  @override
  onDispose() {}
}
