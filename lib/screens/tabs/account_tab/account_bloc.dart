import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/models/profile_options.dart';
import 'package:legalz_hub_app/my_app.dart';
import 'package:legalz_hub_app/services/settings_service.dart';
import 'package:legalz_hub_app/shared_widget/bottom_sheet_util.dart';
import 'package:legalz_hub_app/shared_widget/custom_switch.dart';
import 'package:legalz_hub_app/utils/constants/constant.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/report_type.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/routes.dart';

class AccountBloc {
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  ValueNotifier<bool> toggleOfBiometrics = ValueNotifier<bool>(false);
  UserType userType = UserType.customer;

  List<ProfileOptions> listOfAccountOptions(
      BuildContext context, UserType userType) {
    switch (userType) {
      case UserType.attorney:
        return [
          ProfileOptions(
            icon: Icons.account_box,
            name: AppLocalizations.of(context)!.editprofileinformations,
            onTap: () => Navigator.of(context, rootNavigator: true)
                .pushNamed(RoutesConstants.editProfileScreen),
          ),
          ProfileOptions(
            icon: Icons.explore,
            name: AppLocalizations.of(context)!.editprofileeinexperiances,
            onTap: () => Navigator.of(context, rootNavigator: true)
                .pushNamed(RoutesConstants.editExperienceScreen),
          ),
          ProfileOptions(
            icon: Icons.work_history_outlined,
            name: AppLocalizations.of(context)!.workinghour,
            onTap: () => Navigator.of(context, rootNavigator: true)
                .pushNamed(RoutesConstants.workingHoursScreen),
          ),
          ProfileOptions(
            icon: Ionicons.cash_outline,
            name: AppLocalizations.of(context)!.rateperhour,
            subtitle: AppLocalizations.of(context)!.rateperhoursubtitle,
            avaliable: false,
            onTap: () => Navigator.of(context, rootNavigator: true)
                .pushNamed(RoutesConstants.ratePerHourScreen),
          ),
          ProfileOptions(
            icon: Ionicons.star_half_outline,
            name: AppLocalizations.of(context)!.ratingandreview,
            onTap: () => Navigator.of(context, rootNavigator: true)
                .pushNamed(RoutesConstants.ratingAndReviewScreen),
          ),
          ProfileOptions(
            icon: Icons.password,
            name: AppLocalizations.of(context)!.editprofilepassword,
            onTap: () => Navigator.of(context, rootNavigator: true)
                .pushNamed(RoutesConstants.changePasswordScreen),
          ),
          ProfileOptions(
            icon: Ionicons.finger_print,
            name: AppLocalizations.of(context)!.biometrics,
            selectedItemImage: ValueListenableBuilder<bool>(
              valueListenable: toggleOfBiometrics,
              builder: (BuildContext context, dynamic value, Widget? child) {
                return CustomSwitch(
                    value: toggleOfBiometrics.value,
                    language: box.get(DatabaseFieldConstant.language),
                    backgroundColorOfSelection: toggleOfBiometrics.value
                        ? const Color(0xff34C759)
                        : const Color(0xffE74C4C),
                    onChanged: (_) async {
                      await box.put(DatabaseFieldConstant.biometricStatus,
                          (!toggleOfBiometrics.value).toString());
                      toggleOfBiometrics.value = !toggleOfBiometrics.value;
                    });
              },
            ),
            onTap: () {},
          ),
          ProfileOptions(
            icon: Icons.logout,
            name: AppLocalizations.of(context)!.logout,
            onTap: () => _logoutView(context),
          ),
          ProfileOptions(
            icon: Ionicons.bag_remove_outline,
            iconColor: Colors.red,
            name: AppLocalizations.of(context)!.deleteaccount,
            nameColor: Colors.red,
            onTap: () => _deleteAccountView(context),
          ),
        ];
      case UserType.customer:
        return [
          ProfileOptions(
            icon: Icons.account_box,
            name: AppLocalizations.of(context)!.editprofileinformations,
            onTap: () => Navigator.of(context, rootNavigator: true)
                .pushNamed(RoutesConstants.editProfileScreen),
          ),
          ProfileOptions(
            icon: Icons.password,
            name: AppLocalizations.of(context)!.editprofilepassword,
            onTap: () => Navigator.of(context, rootNavigator: true)
                .pushNamed(RoutesConstants.changePasswordScreen),
          ),
          ProfileOptions(
            icon: Ionicons.finger_print,
            name: AppLocalizations.of(context)!.biometrics,
            selectedItemImage: ValueListenableBuilder<bool>(
              valueListenable: toggleOfBiometrics,
              builder: (BuildContext context, dynamic value, Widget? child) {
                return CustomSwitch(
                    value: toggleOfBiometrics.value,
                    language: box.get(DatabaseFieldConstant.language),
                    backgroundColorOfSelection: toggleOfBiometrics.value
                        ? const Color(0xff34C759)
                        : const Color(0xffE74C4C),
                    onChanged: (_) async {
                      await box.put(DatabaseFieldConstant.biometricStatus,
                          (!toggleOfBiometrics.value).toString());
                      toggleOfBiometrics.value = !toggleOfBiometrics.value;
                    });
              },
            ),
            onTap: () {},
          ),
          ProfileOptions(
            icon: Icons.logout,
            name: AppLocalizations.of(context)!.logout,
            onTap: () {
              _logoutView(context);
            },
          ),
          ProfileOptions(
            icon: Ionicons.bag_remove_outline,
            iconColor: Colors.red,
            name: AppLocalizations.of(context)!.deleteaccount,
            nameColor: Colors.red,
            onTap: () {
              _deleteAccountView(context);
            },
          ),
        ];
    }
  }

  List<ProfileOptions> listOfSettingsOptions(BuildContext context) {
    return [
      ProfileOptions(
        icon: Icons.translate,
        name: AppLocalizations.of(context)!.language,
        selectedItem: box.get(DatabaseFieldConstant.language) == "en"
            ? "English"
            : "العربية",
        onTap: () => _changeLanguage(context),
      ),
    ];
  }

  List<ProfileOptions> listOfReachOutUsOptions(BuildContext context) {
    return [
      ProfileOptions(
        icon: Icons.bug_report,
        name: AppLocalizations.of(context)!.reportproblem,
        onTap: () => Navigator.of(context, rootNavigator: true)
            .pushNamed(RoutesConstants.reportScreen, arguments: {
          AppConstant.reportType: ReportPageType.issue,
        }),
      ),
      ProfileOptions(
        icon: Ionicons.balloon,
        name: AppLocalizations.of(context)!.reportsuggestion,
        onTap: () => Navigator.of(context, rootNavigator: true)
            .pushNamed(RoutesConstants.reportScreen, arguments: {
          AppConstant.reportType: ReportPageType.suggestion,
        }),
      ),
    ];
  }

  List<ProfileOptions> listOfSupportOptions(BuildContext context) {
    var list = [
      ProfileOptions(
        icon: Ionicons.color_palette,
        name: AppLocalizations.of(context)!.aboutus,
        onTap: () => _openAboutUs(context),
      )
    ];

    if (!kIsWeb) {
      list.add(ProfileOptions(
        icon: Ionicons.person_add,
        name: AppLocalizations.of(context)!.invite_friends,
        onTap: () => _openInviteFriends(context),
      ));
    }

    return list;
  }

  void _deleteAccountView(BuildContext context) {
    var nav = Navigator.of(context, rootNavigator: true);

    BottomSheetsUtil().areYouShoureButtomSheet(
        context: context,
        message: AppLocalizations.of(context)!.areyousuredeleteaccount,
        sure: () async {
          BottomSheetsUtil().areYouShoureButtomSheet(
              context: context,
              message:
                  AppLocalizations.of(context)!.accountInformationwillbedeleted,
              sure: () async {
                locator<SettingService>()
                    .removeAccount(userType)
                    .then((c) async {
                  await _deleteAllUserData().then((value) async {
                    await nav.pushNamedAndRemoveUntil(
                        RoutesConstants.initialRoute,
                        (Route<dynamic> route) => true);
                  });
                });
              });
        });
  }

  void _logoutView(BuildContext context) {
    var nav = Navigator.of(context, rootNavigator: true);
    BottomSheetsUtil().areYouShoureButtomSheet(
        context: context,
        message: AppLocalizations.of(context)!.areyousurelogout,
        sure: () async {
          await _deleteAllUserData();
          await nav.pushNamedAndRemoveUntil(
              RoutesConstants.initialRoute, (Route<dynamic> route) => true);
        });
  }

  Future<void> _deleteAllUserData() {
    return box.deleteAll([
      DatabaseFieldConstant.apikey,
      DatabaseFieldConstant.userType,
      DatabaseFieldConstant.token,
      DatabaseFieldConstant.language,
      DatabaseFieldConstant.userid,
      DatabaseFieldConstant.selectedCountryId,
      DatabaseFieldConstant.selectedCountryFlag,
      DatabaseFieldConstant.attorneyRegistrationStep,
      DatabaseFieldConstant.customerRegistrationStep,
      DatabaseFieldConstant.saveEmailAndPassword,
      DatabaseFieldConstant.biometricU,
      DatabaseFieldConstant.biometricP,
      DatabaseFieldConstant.biometricStatus,
      DatabaseFieldConstant.selectedCountryId,
      DatabaseFieldConstant.selectedCountryFlag,
      DatabaseFieldConstant.selectedCountryName,
      DatabaseFieldConstant.selectedCountryCurrency,
      DatabaseFieldConstant.selectedCountryCode,
      DatabaseFieldConstant.selectedCurrencyCode,
      DatabaseFieldConstant.selectedCountryDialCode,
      DatabaseFieldConstant.selectedCountryMinLenght,
      DatabaseFieldConstant.selectedCountryMaxLenght,
      DatabaseFieldConstant.pushNotificationToken,
    ]);
  }

  void _openInviteFriends(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .pushNamed(RoutesConstants.inviteFriendScreen);
  }

  void _changeLanguage(BuildContext context) async {
    await BottomSheetsUtil().areYouShoureButtomSheet(
        context: context,
        message: AppLocalizations.of(context)!.changelanguagemessage,
        sure: () {
          if (box.get(DatabaseFieldConstant.language) == "en") {
            box.put(DatabaseFieldConstant.language, "ar");
            _refreshAppWithLanguageCode(context);
          } else {
            box.put(DatabaseFieldConstant.language, "en");
            _refreshAppWithLanguageCode(context);
          }
        });
  }

  void _refreshAppWithLanguageCode(BuildContext context) async {
    MyApp.of(context)!.rebuild();
  }

  readBiometricsInitValue() {
    toggleOfBiometrics.value =
        box.get(DatabaseFieldConstant.biometricStatus) == "true";
  }

  void _openAboutUs(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .pushNamed(RoutesConstants.webViewScreen, arguments: {
      AppConstant.webViewPageUrl:
          box.get(DatabaseFieldConstant.language) == "en"
              ? AppConstant.aboutusLink
              : AppConstant.aboutusLinkAR,
      AppConstant.pageTitle: AppLocalizations.of(context)!.aboutus
    });
  }
}
