import 'dart:async';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/screens/main_container/widgets/tab_navigator.dart';
import 'package:legalz_hub_app/services/noticitions_services.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/routes.dart';

enum CustomerSelectedTab { home, categories, call, calender, account }

enum AttorneySelectedTab { home, payment, call, calender, account }

class MainContainerBloc {
  final ValueNotifier<CustomerSelectedTab> customerCurrentTabIndexNotifier =
      ValueNotifier<CustomerSelectedTab>(CustomerSelectedTab.home);
  final ValueNotifier<AttorneySelectedTab> attornyCurrentTabIndexNotifier =
      ValueNotifier<AttorneySelectedTab>(AttorneySelectedTab.home);

  final box = Hive.box(DatabaseBoxConstant.userInfo);
  UserType userType = UserType.attorney;

  GlobalKey<ConvexAppBarState> appBarKey = GlobalKey<ConvexAppBarState>();

  List<TabNavigator> customerNavTabs = const [
    TabNavigator(initialRoute: RoutesConstants.homeScreen),
    TabNavigator(initialRoute: RoutesConstants.categoriesScreen),
    TabNavigator(initialRoute: RoutesConstants.callScreen),
    TabNavigator(initialRoute: RoutesConstants.calenderScreen),
    TabNavigator(initialRoute: RoutesConstants.accountScreen)
  ];

  List<TabNavigator> attornyNavTabs = const [
    TabNavigator(initialRoute: RoutesConstants.homeScreen),
    TabNavigator(initialRoute: RoutesConstants.paymentsScreen),
    TabNavigator(initialRoute: RoutesConstants.callScreen),
    TabNavigator(initialRoute: RoutesConstants.calenderScreen),
    TabNavigator(initialRoute: RoutesConstants.accountScreen)
  ];

  AttorneySelectedTab returnAttornySelectedtypeDependOnIndex(int index) {
    switch (index) {
      case 0:
        return AttorneySelectedTab.home;
      case 1:
        return AttorneySelectedTab.payment;
      case 2:
        return AttorneySelectedTab.call;
      case 3:
        return AttorneySelectedTab.calender;
      default:
        return AttorneySelectedTab.account;
    }
  }

  CustomerSelectedTab returnCustomerSelectedtypeDependOnIndex(int index) {
    switch (index) {
      case 0:
        return CustomerSelectedTab.home;
      case 1:
        return CustomerSelectedTab.categories;
      case 2:
        return CustomerSelectedTab.call;
      case 3:
        return CustomerSelectedTab.calender;
      default:
        return CustomerSelectedTab.account;
    }
  }

  int getAttorneySelectedIndexDependOnTab(AttorneySelectedTab tab) {
    switch (tab) {
      case AttorneySelectedTab.home:
        return 0;
      case AttorneySelectedTab.payment:
        return 1;
      case AttorneySelectedTab.call:
        return 2;
      case AttorneySelectedTab.calender:
        return 3;
      case AttorneySelectedTab.account:
        return 4;
      default:
        return 0;
    }
  }

  int getCustomerSelectedIndexDependOnTab(CustomerSelectedTab tab) {
    switch (tab) {
      case CustomerSelectedTab.home:
        return 0;
      case CustomerSelectedTab.categories:
        return 1;
      case CustomerSelectedTab.call:
        return 2;
      case CustomerSelectedTab.calender:
        return 3;
      case CustomerSelectedTab.account:
        return 4;
      default:
        return 0;
    }
  }

  Future<void> callRegisterTokenRequest(UserType userType) async {
    final token = box.get(DatabaseFieldConstant.pushNotificationToken);
    if (token != null && token != "") {
      await locator<NotificationsService>().registerToken(token, userType);
    }
  }
}
