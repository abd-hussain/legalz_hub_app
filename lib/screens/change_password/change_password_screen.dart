import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legalz_hub_app/models/password_strength_model.dart';
import 'package:legalz_hub_app/screens/change_password/change_password_bloc.dart';
import 'package:legalz_hub_app/screens/change_password/widgets/password_strenght.dart';
import 'package:legalz_hub_app/shared_widget/custom_appbar.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/shared_widget/custom_textfield.dart';
import 'package:legalz_hub_app/shared_widget/password_strenght_logic.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/utils/error/exceptions.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final bloc = ChangePasswordBloc();

  @override
  void didChangeDependencies() {
    bloc.infoNotifier.value = AppLocalizations.of(context)!.fillcurrentpassword;

    bloc.userType = bloc.box.get(DatabaseFieldConstant.userType) == "customer"
        ? UserType.customer
        : UserType.attorney;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF3F4F5),
        resizeToAvoidBottomInset: false,
        appBar:
            customAppBar(title: AppLocalizations.of(context)!.changepassword),
        body: SafeArea(
          child: ValueListenableBuilder<LoadingStatus>(
              valueListenable: bloc.loadingStatus,
              builder: (context, loadingsnapshot, child) {
                if (loadingsnapshot != LoadingStatus.inprogress) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.5,
                                blurRadius: 5,
                                offset: const Offset(0, 0.1),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: ValueListenableBuilder<String>(
                                    valueListenable: bloc.infoNotifier,
                                    builder: (context, snapshot, child) {
                                      return CustomText(
                                        title: snapshot,
                                        fontSize: 12,
                                        textColor: const Color(0xff444444),
                                      );
                                    }),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 50,
                                child: CustomTextField(
                                  controller:
                                      bloc.currentPasswordFieldController,
                                  hintText:
                                      AppLocalizations.of(context)!.oldpassword,
                                  keyboardType: TextInputType.text,
                                  obscureText: bloc.currentPassowrdObscureText,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(30),
                                  ],
                                  suffixWidget: SizedBox(
                                    height: 35,
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            bloc.currentPassowrdObscureText =
                                                !bloc
                                                    .currentPassowrdObscureText;
                                          });
                                        },
                                        icon: Icon(
                                            bloc.currentPassowrdObscureText
                                                ? Icons.visibility
                                                : Icons.visibility_off)),
                                  ),
                                  onChange: (text) {
                                    if (text.isNotEmpty) {
                                      if (bloc.validateCurrentPassword(
                                          context, text)) {
                                        FocusScope.of(context).unfocus();
                                      }
                                    }
                                  },
                                  onEditingComplete: () =>
                                      FocusScope.of(context).unfocus(),
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 50,
                                child: CustomTextField(
                                  controller: bloc.newPasswordFieldController,
                                  enabled: bloc.enableNewPasswordTextField,
                                  hintText:
                                      AppLocalizations.of(context)!.newpassword,
                                  keyboardType: TextInputType.text,
                                  obscureText: bloc.newPasswordObscureText,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(30),
                                  ],
                                  suffixWidget: SizedBox(
                                    height: 32,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          bloc.newPasswordObscureText =
                                              !bloc.newPasswordObscureText;
                                        });
                                      },
                                      icon: Icon(bloc.newPasswordObscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                    ),
                                  ),
                                  onChange: (text) {
                                    if (text.isNotEmpty) {
                                      PasswordsStrength().validatePasswordStrength(
                                          passwordFieldController:
                                              bloc.newPasswordFieldController,
                                          passwordStrengthValidationNotifier: bloc
                                              .passwordStrengthValidationNotifier);
                                      setState(() {
                                        if (PasswordsStrength()
                                            .checkerOfThePasswordStrength(
                                                passwordStrengthValidationNotifier:
                                                    bloc.passwordStrengthValidationNotifier)) {
                                          bloc.enableConfirmPasswordTextField =
                                              true;
                                          bloc.infoNotifier.value =
                                              AppLocalizations.of(context)!
                                                  .fillconfirmpassword;
                                        } else {
                                          bloc.enableConfirmPasswordTextField =
                                              false;
                                        }
                                        if (bloc.newPasswordFieldController
                                                .text ==
                                            bloc.confirmPasswordFieldController
                                                .text) {
                                          bloc.enableSaveButton = true;
                                        } else {
                                          bloc.enableSaveButton = false;
                                        }
                                      });
                                    } else {
                                      bloc.passwordStrengthValidationNotifier
                                          .value = PasswordStrengthModel();
                                    }
                                  },
                                  onEditingComplete: () =>
                                      FocusScope.of(context).unfocus(),
                                ),
                              ),
                              PasswordStrengtView(
                                passwordStrengthValidationNotifier:
                                    bloc.passwordStrengthValidationNotifier,
                              ),
                              SizedBox(
                                height: 50,
                                child: CustomTextField(
                                  controller:
                                      bloc.confirmPasswordFieldController,
                                  hintText: AppLocalizations.of(context)!
                                      .newpasswordagain,
                                  keyboardType: TextInputType.text,
                                  enabled: bloc.enableConfirmPasswordTextField,
                                  obscureText: bloc.confirmPasswordObscureText,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(30),
                                  ],
                                  suffixWidget: SizedBox(
                                    height: 32,
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          bloc.confirmPasswordObscureText =
                                              !bloc.confirmPasswordObscureText;
                                        });
                                      },
                                      icon: Icon(bloc.confirmPasswordObscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                    ),
                                  ),
                                  onChange: (text) {
                                    setState(() {
                                      if (bloc.newPasswordFieldController
                                              .text ==
                                          bloc.confirmPasswordFieldController
                                              .text) {
                                        bloc.enableSaveButton = true;
                                      } else {
                                        bloc.enableSaveButton = false;
                                      }
                                    });
                                  },
                                  onEditingComplete: () =>
                                      FocusScope.of(context).unfocus(),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      CustomButton(
                          enableButton: bloc.enableSaveButton,
                          onTap: () async {
                            bloc.loadingStatus.value = LoadingStatus.inprogress;
                            final scaffoldMessenger =
                                ScaffoldMessenger.of(context);
                            final navigation = Navigator.of(context);
                            try {
                              await bloc
                                  .changePasswordRequest()
                                  .then((value) async {
                                bloc.loadingStatus.value = LoadingStatus.finish;
                                await bloc.box.put(
                                    DatabaseFieldConstant.biometricP,
                                    bloc.newPasswordFieldController.text);
                                navigation.pop();
                              });
                            } on DioException catch (e) {
                              final error = e.error as HttpException;
                              bloc.loadingStatus.value = LoadingStatus.finish;
                              scaffoldMessenger.showSnackBar(
                                SnackBar(
                                    content: Text(error.message.toString())),
                              );
                            }
                          }),
                    ],
                  );
                } else {
                  return const SizedBox(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ),
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
