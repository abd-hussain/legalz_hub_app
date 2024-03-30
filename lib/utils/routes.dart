import 'package:flutter/material.dart';
import 'package:legalz_hub_app/screens/initial/initial_screen.dart';

class RoutesConstants {
  static const String initialRoute = 'initScreen';
  static const String loginScreen = 'loginScreen';
  static const String reportScreen = 'reportScreen';
  static const String mainContainer = 'mainContainer';
  static const String homeScreen = 'homeScreen';
  static const String callScreen = 'callScreen';
  static const String calenderScreen = 'calenderScreen';
  static const String accountScreen = 'accountScreen';
  static const String registerfaze2Screen = 'registerfaze2Screen';
  static const String registerfaze3Screen = 'registerfaze3Screen';
  static const String registerfaze4Screen = 'registerfaze4Screen';
  static const String registerfaze5Screen = 'registerfaze5Screen';
  static const String registerfaze6Screen = 'registerfaze6Screen';
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
  //TODO

  // RoutesConstants.mainContainer: const MainContainer(),
  // RoutesConstants.homeScreen: const HomeScreen(),
  // RoutesConstants.callScreen: const CallScreen(),
  // RoutesConstants.insideCallScreen: const InsideCallScreen(),
  // RoutesConstants.calenderScreen: const CalenderScreen(),
  // RoutesConstants.accountScreen: const AccountScreen(),
  // RoutesConstants.registerfaze2Screen: const RegisterFaze2Screen(),
  // RoutesConstants.registerfaze3Screen: const RegisterFaze3Screen(),
  // RoutesConstants.registerfaze4Screen: const RegisterFaze4Screen(),
  // RoutesConstants.registerfaze5Screen: const RegisterFaze5Screen(),
  // RoutesConstants.registerfaze6Screen: const RegisterFaze6Screen(),
  // RoutesConstants.registerfinalfazeScreen: const RegisterFinalScreen(),
  // RoutesConstants.webViewScreen: const WebViewScreen(),
  // RoutesConstants.inviteFriendScreen: const InviteFriendsScreen(),
  // RoutesConstants.reportScreen: const ReportScreen(),
  // RoutesConstants.tutorialsScreen: const TutorialsScreen(),
  // RoutesConstants.changePasswordScreen: const ChangePasswordScreen(),
  // RoutesConstants.editProfileScreen: const EditProfileScreen(),
  // RoutesConstants.editExperienceScreen: const EditExperienceScreen(),
  // RoutesConstants.workingHoursScreen: const WorkingHoursScreen(),
  // RoutesConstants.ratePerHourScreen: const RatePerHourScreen(),
  // RoutesConstants.paymentsScreen: const PaymentsScreen(),
  // RoutesConstants.notificationsScreen: const NotificationsScreen(),
  // RoutesConstants.forgotPasswordScreen: const ForgotPasswordScreen(),
  // RoutesConstants.forgotPasswordConfirmationScreen: const ForgotPasswordConfirmationScreen(),
  // RoutesConstants.ratingAndReviewScreen: const RatingAndReviewScreen()
};
