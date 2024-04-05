import 'package:flutter/material.dart';
import 'package:legalz_hub_app/screens/forgot_password/forgot_password_confirmation_screen.dart';
import 'package:legalz_hub_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:legalz_hub_app/screens/initial/initial_screen.dart';
import 'package:legalz_hub_app/screens/login/login_screen.dart';
import 'package:legalz_hub_app/screens/register/attorney/fase_1/attorney_register_fase1_screen.dart';
import 'package:legalz_hub_app/screens/register/attorney/fase_2/attorney_register_fase2_screen.dart';
import 'package:legalz_hub_app/screens/register/attorney/fase_3/attorney_register_fase3_screen.dart';
import 'package:legalz_hub_app/screens/register/attorney/fase_4/attorney_register_fase4_screen.dart';
import 'package:legalz_hub_app/screens/register/attorney/fase_5/attorney_register_fase5_screen.dart';
import 'package:legalz_hub_app/screens/register/customer/fase_1/customer_register_fase1_screen.dart';
import 'package:legalz_hub_app/screens/register/customer/fase_2/customer_register_fase2_screen.dart';
import 'package:legalz_hub_app/screens/register/final_stage/register_final_screen.dart';
import 'package:legalz_hub_app/screens/tutorials/tutorials_screen.dart';

class RoutesConstants {
  static const String initialRoute = 'initScreen';
  static const String loginScreen = 'loginScreen';
  static const String reportScreen = 'reportScreen';
  static const String mainContainer = 'mainContainer';
  static const String homeScreen = 'homeScreen';
  static const String callScreen = 'callScreen';
  static const String calenderScreen = 'calenderScreen';
  static const String accountScreen = 'accountScreen';
  static const String registerAttornyFaze1Screen = 'registerAttornyFaze1Screen';
  static const String registerAttornyFaze2Screen = 'registerAttornyFaze2Screen';
  static const String registerAttornyFaze3Screen = 'registerAttornyFaze3Screen';
  static const String registerAttornyFaze4Screen = 'registerAttornyFaze4Screen';
  static const String registerAttornyFaze5Screen = 'registerAttornyFaze5Screen';
  static const String registerCustomerFaze1Screen =
      'registerCustomerFaze1Screen';
  static const String registerCustomerFaze2Screen =
      'registerCustomerFaze2Screen';

  static const String registerfinalfazeScreen = 'registerfinalfazeScreen';
  static const String notificationsScreen = 'notificationsScreen';
  static const String webViewScreen = 'webViewScreen';
  static const String inviteFriendScreen = 'inviteFriendScreen';
  static const String tutorialsScreen = 'tutorialsScreen';
  static const String changePasswordScreen = 'changePasswordScreen';
  static const String editProfileScreen = 'editProfileScreen';
  static const String editExperienceScreen = 'editExperienceScreen';
  static const String workingHoursScreen = 'workingHoursScreen';
  static const String ratePerHourScreen = 'ratePerHourScreen';

  static const String paymentsScreen = 'paymentsScreen';
  static const String forgotPasswordScreen = 'forgotPasswordScreen';
  static const String eventDetailsScreen = 'eventDetailsScreen';
  static const String forgotPasswordConfirmationScreen =
      'forgotPasswordConfirmationScreen';
  static const String insideCallScreen = 'InsideCallScreen';
  static const String ratingAndReviewScreen = 'ratingAndReviewScreen';
}

final Map<String, Widget> routes = {
  RoutesConstants.initialRoute: const InitialScreen(),
  RoutesConstants.loginScreen: const LoginScreen(),
  RoutesConstants.tutorialsScreen: const TutorialsScreen(),
  RoutesConstants.forgotPasswordScreen: const ForgotPasswordScreen(),
  RoutesConstants.forgotPasswordConfirmationScreen:
      const ForgotPasswordConfirmationScreen(),
  RoutesConstants.registerAttornyFaze1Screen: const AttorneyRegister1Screen(),
  RoutesConstants.registerAttornyFaze2Screen: const AttorneyRegister2Screen(),
  RoutesConstants.registerAttornyFaze3Screen: const AttorneyRegister3Screen(),
  RoutesConstants.registerAttornyFaze4Screen: const AttorneyRegister4Screen(),
  RoutesConstants.registerAttornyFaze5Screen: const AttorneyRegister5Screen(),

  RoutesConstants.registerCustomerFaze1Screen: const CustomerRegister1Screen(),
  RoutesConstants.registerCustomerFaze2Screen: const CustomerRegister2Screen(),

  RoutesConstants.registerfinalfazeScreen: const RegisterFinalScreen(),

  //TODO

  // RoutesConstants.mainContainer: const MainContainer(),
  // RoutesConstants.homeScreen: const HomeScreen(),
  // RoutesConstants.callScreen: const CallScreen(),
  // RoutesConstants.insideCallScreen: const InsideCallScreen(),
  // RoutesConstants.calenderScreen: const CalenderScreen(),
  // RoutesConstants.accountScreen: const AccountScreen(),
  // RoutesConstants.webViewScreen: const WebViewScreen(),
  // RoutesConstants.inviteFriendScreen: const InviteFriendsScreen(),
  // RoutesConstants.reportScreen: const ReportScreen(),

  // RoutesConstants.changePasswordScreen: const ChangePasswordScreen(),
  // RoutesConstants.editProfileScreen: const EditProfileScreen(),
  // RoutesConstants.editExperienceScreen: const EditExperienceScreen(),
  // RoutesConstants.workingHoursScreen: const WorkingHoursScreen(),
  // RoutesConstants.ratePerHourScreen: const RatePerHourScreen(),
  // RoutesConstants.paymentsScreen: const PaymentsScreen(),
  // RoutesConstants.notificationsScreen: const NotificationsScreen(),
  // RoutesConstants.ratingAndReviewScreen: const RatingAndReviewScreen()
};
