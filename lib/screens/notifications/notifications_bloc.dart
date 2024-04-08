import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/models/https/notifications_response.dart';
import 'package:legalz_hub_app/services/noticitions_services.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/mixins.dart';

class NotificationsBloc extends Bloc<NotificationsService> {
  final ValueNotifier<List<NotificationsResponseData>?>
      notificationsListNotifier =
      ValueNotifier<List<NotificationsResponseData>?>(null);
  UserType userType = UserType.customer;
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  Future<void> pullRefresh() async {
    return Future.delayed(
      const Duration(milliseconds: 1000),
      () => listOfNotifications(userType),
    );
  }

  void listOfNotifications(UserType userType) {
    service.listOfNotifications(userType).then((value) {
      notificationsListNotifier.value = value.data;
    });
  }

  @override
  onDispose() {
    notificationsListNotifier.dispose();
  }
}
