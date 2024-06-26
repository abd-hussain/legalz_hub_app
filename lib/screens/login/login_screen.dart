import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/models/authentication_models.dart';
import 'package:legalz_hub_app/screens/login/login_bloc.dart';
import 'package:legalz_hub_app/screens/login/widgets/biometric_login_view.dart';
import 'package:legalz_hub_app/screens/login/widgets/forgot_password_widget.dart';
import 'package:legalz_hub_app/screens/login/widgets/save_password_view.dart';
import 'package:legalz_hub_app/screens/register/widgets/attoreny_bottom_sheet.dart';
import 'package:legalz_hub_app/screens/register/widgets/customer_bottom_sheet.dart';
import 'package:legalz_hub_app/screens/register/widgets/select_user_type_bottom_sheet.dart';
import 'package:legalz_hub_app/shared_widget/background_container.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/shared_widget/email_field.dart';
import 'package:legalz_hub_app/shared_widget/loading_view.dart';
import 'package:legalz_hub_app/shared_widget/password_field.dart';
import 'package:legalz_hub_app/utils/constants/constant.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bloc = LoginBloc();

  @override
  void didChangeDependencies() {
    bloc.maincontext = context;
    bloc.initBiometric(context);
    bloc.handleListeners();
    bloc.getUserNameAndPasswordWhenSavePasswordTicked();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: ValueListenableBuilder<LoadingStatus>(
              valueListenable: bloc.loadingStatusNotifier,
              builder: (context, snapshot, child) {
                return snapshot == LoadingStatus.inprogress
                    ? const LoadingView()
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Image.asset(
                              "assets/images/logoz/logo-blue.png",
                              height: 100,
                              width: 150,
                            ),
                            BackgroundContainer(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 30),
                                  EmailFieldLogin(
                                    controller: bloc.emailController,
                                    onClear: () {
                                      bloc.emailController.clear();
                                      bloc.showHideEmailClearNotifier.value =
                                          false;
                                      bloc.fieldsValidations.value = false;
                                    },
                                    onchange: bloc.fieldValidation,
                                    onEditingComplete: () => FocusManager
                                        .instance.primaryFocus
                                        ?.unfocus(),
                                    showHideEmailClearNotifier:
                                        bloc.showHideEmailClearNotifier,
                                  ),
                                  const SizedBox(height: 20),
                                  PasswordField(
                                    controller: bloc.passwordController,
                                    onClear: () {
                                      bloc.passwordController.clear();
                                      bloc.showHidePasswordClearNotifier.value =
                                          false;
                                      bloc.fieldsValidations.value = false;
                                    },
                                    onchange: bloc.fieldValidation,
                                    showHidePasswordClearNotifier:
                                        bloc.showHidePasswordClearNotifier,
                                    onEditingComplete: () => FocusManager
                                        .instance.primaryFocus
                                        ?.unfocus(),
                                  ),
                                  SavePasswordLoginView(
                                    initialValue: bloc.box.get(
                                            DatabaseFieldConstant
                                                .saveEmailAndPassword) ??
                                        false,
                                    selectedStatus: (val) {
                                      bloc.box.put(
                                          DatabaseFieldConstant
                                              .saveEmailAndPassword,
                                          val);
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Center(
                                      child: ValueListenableBuilder<String>(
                                          valueListenable: bloc.errorMessage,
                                          builder: (context, snapshot, child) {
                                            return CustomText(
                                              title: snapshot,
                                              fontSize: 14,
                                              maxLins: 2,
                                              textAlign: TextAlign.center,
                                              textColor: Colors.red,
                                            );
                                          }),
                                    ),
                                  ),
                                  ValueListenableBuilder<bool>(
                                      valueListenable: bloc.fieldsValidations,
                                      builder: (context, snapshot, child) {
                                        return CustomButton(
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          buttonTitle:
                                              AppLocalizations.of(context)!
                                                  .login,
                                          enableButton: snapshot,
                                          onTap: () {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            bloc.doLoginCall(
                                              context: context,
                                              userName: bloc
                                                  .emailController.text
                                                  .trim(),
                                              password:
                                                  bloc.passwordController.text,
                                            );
                                          },
                                        );
                                      }),
                                  ValueListenableBuilder<
                                          AuthenticationBiometricType>(
                                      valueListenable:
                                          bloc.biometricResultNotifier,
                                      builder: (context, snapshot, child) {
                                        return (snapshot.isAvailable &&
                                                bloc.biometricStatus)
                                            ? BiometrincLoginView(
                                                biometricType: snapshot.type,
                                                onPress: () async {
                                                  final contextScafold =
                                                      ScaffoldMessenger.of(
                                                          context);

                                                  if (!bloc
                                                      .isBiometricAppeared) {
                                                    if (context.mounted) {
                                                      await bloc.box.get(
                                                                  DatabaseFieldConstant
                                                                      .biometricStatus) ==
                                                              'true'
                                                          // ignore: use_build_context_synchronously
                                                          ? await bloc
                                                              .tryToAuthintecateUserByBiometric(
                                                                  context)
                                                          : contextScafold
                                                              .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                    // ignore: use_build_context_synchronously
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .biometricsisdisable),
                                                              ),
                                                            );
                                                    }
                                                  }
                                                },
                                              )
                                            : const SizedBox();
                                      }),
                                  const ForgotPasswordWidget(),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(50, 16, 50, 5),
                              child: CustomText(
                                textAlign: TextAlign.center,
                                title: AppLocalizations.of(context)!
                                    .dontHaveAccount,
                                textColor: const Color(0xff212C34),
                                fontSize: 14,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(50, 0, 50, 16),
                              child: InkWell(
                                onTap: () {
                                  final selectUserTypeBottomsheet =
                                      SelectUserTypeRegisterBottomSheetsUtil(
                                          context: context);
                                  selectUserTypeBottomsheet.infoBottomSheet(
                                      openNext: (userType) {
                                    whereToGo(userType, context);
                                  });
                                },
                                child: CustomText(
                                  textAlign: TextAlign.center,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  title: AppLocalizations.of(context)!
                                      .registerAccount,
                                  textColor: const Color(0xff0059FF),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
              }),
        ),
      ),
    );
  }

  void whereToGo(UserType userType, BuildContext context) {
    switch (userType) {
      case UserType.attorney:
        final String step =
            bloc.box.get(DatabaseFieldConstant.attorneyRegistrationStep) ?? "0";
        final int stepNum = int.parse(step);
        final bottomsheet = RegisterAttorneyBottomSheetsUtil(
          context: context,
          language: bloc.box.get(DatabaseFieldConstant.language) ?? "",
        );

        bottomsheet.infoBottomSheet(
            step: stepNum,
            openNext: () {
              switch (stepNum) {
                case 1:
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(RoutesConstants.registerAttornyFaze1Screen);
                  break;
                case 2:
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(RoutesConstants.registerAttornyFaze2Screen);
                  break;
                case 3:
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(RoutesConstants.registerAttornyFaze3Screen);
                  break;
                case 4:
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(RoutesConstants.registerAttornyFaze4Screen);
                  break;
                case 5:
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(RoutesConstants.registerAttornyFaze5Screen);
                  break;
                case 6:
                  Navigator.of(context, rootNavigator: true).pushNamed(
                      RoutesConstants.registerfinalfazeScreen,
                      arguments: {AppConstant.userType: UserType.attorney});
                  break;
                default:
                  Navigator.of(context, rootNavigator: true).pushNamed(
                      RoutesConstants.registerTermsAndConditionScreen,
                      arguments: {AppConstant.userType: UserType.attorney});
                  break;
              }
            });
      case UserType.customer:
        final String step =
            bloc.box.get(DatabaseFieldConstant.customerRegistrationStep) ?? "0";
        final int stepNum = int.parse(step);
        final bottomsheet = RegisterCustomerBottomSheetsUtil(
          context: context,
          language: bloc.box.get(DatabaseFieldConstant.language) ?? "",
        );
        bottomsheet.infoBottomSheet(
            step: stepNum,
            openNext: () {
              switch (stepNum) {
                case 1:
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(RoutesConstants.registerCustomerFaze1Screen);
                  break;
                case 2:
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(RoutesConstants.registerCustomerFaze2Screen);
                  break;
                case 3:
                  Navigator.of(context, rootNavigator: true).pushNamed(
                      RoutesConstants.registerfinalfazeScreen,
                      arguments: {AppConstant.userType: UserType.customer});
                  break;
                default:
                  Navigator.of(context, rootNavigator: true).pushNamed(
                      RoutesConstants.registerTermsAndConditionScreen,
                      arguments: {AppConstant.userType: UserType.customer});
                  break;
              }
            });
    }
  }
}
