import 'dart:async';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/models/https/categories_model.dart';
import 'package:legalz_hub_app/screens/main_container/widgets/tab_navigator.dart';
import 'package:legalz_hub_app/services/filter_services.dart';
import 'package:legalz_hub_app/services/noticitions_services.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/error/exceptions.dart';
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

  List<TabItem<dynamic>> customerItems(BuildContext context) {
    return [
      TabItem(
          icon: Icons.home,
          title: AppLocalizations.of(context)!.containerHomeIconTitle),
      TabItem(
          icon: Icons.category_rounded,
          title: AppLocalizations.of(context)!.category),
      const TabItem(icon: Icons.call),
      TabItem(
          icon: Icons.calendar_month,
          title: AppLocalizations.of(context)!.containerCalenderIconTitle),
      TabItem(
          icon: Icons.person,
          title: AppLocalizations.of(context)!.containerAccountIconTitle),
    ];
  }

  List<TabItem<dynamic>> attorneyItems(BuildContext context) {
    return [
      TabItem(
          icon: Icons.home,
          title: AppLocalizations.of(context)!.containerHomeIconTitle),
      TabItem(
          icon: Icons.payments_outlined,
          title: AppLocalizations.of(context)!.payments),
      const TabItem(icon: Icons.call),
      TabItem(
          icon: Icons.calendar_month,
          title: AppLocalizations.of(context)!.containerCalenderIconTitle),
      TabItem(
          icon: Icons.person,
          title: AppLocalizations.of(context)!.containerAccountIconTitle),
    ];
  }

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

  Future<void> callRegisterTokenRequest(
      BuildContext context, UserType userType) async {
    final token = box.get(DatabaseFieldConstant.pushNotificationToken);
    if (token != null && token != "") {
      try {
        await locator<NotificationsService>().registerToken(token, userType);
      } on ConnectionException {
        final scaffoldMessenger = ScaffoldMessenger.of(context);
        scaffoldMessenger.showSnackBar(
          SnackBar(
              content: Text(AppLocalizations.of(context)!
                  .pleasecheckyourinternetconnection)),
        );
      }
    }
  }

  Future<List<Category>> getlistOfCategories(BuildContext context) async {
    return locator<FilterService>().categories().then((value) {
      final List<Category> list = value.data!
        ..sort((a, b) => a.id!.compareTo(b.id!));

      list.insert(0, Category(id: 0, name: AppLocalizations.of(context)!.all));

      return list;
    });
  }
}
