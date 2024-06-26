import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/screens/forgot_password/forgot_password_bloc.dart';
import 'package:legalz_hub_app/shared_widget/background_container.dart';
import 'package:legalz_hub_app/shared_widget/custom_appbar.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/shared_widget/email_field.dart';
import 'package:legalz_hub_app/shared_widget/loading_view.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/error/exceptions.dart';
import 'package:legalz_hub_app/utils/routes.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final bloc = ForgotPasswordBloc();

  @override
  void didChangeDependencies() {
    bloc.maincontext = context;
    bloc.handleListeners();
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
      appBar: customAppBar(
        title: AppLocalizations.of(context)!.forgotpassword,
        userType: UserType.customer,
      ),
      body: ValueListenableBuilder<LoadingStatus>(
          valueListenable: bloc.loadingStatusNotifier,
          builder: (context, snapshot, child) {
            return snapshot == LoadingStatus.inprogress
                ? const LoadingView()
                : GestureDetector(
                    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                    child: Container(
                      margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
                      child: BackgroundContainer(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 35, right: 16, bottom: 25),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: CustomText(
                                  maxLins: 2,
                                  title: AppLocalizations.of(context)!
                                      .resetpasswordtitle,
                                  fontSize: 14,
                                  textAlign: TextAlign.center,
                                  textColor: const Color(0xff191C1F),
                                ),
                              ),
                              const SizedBox(height: 20),
                              EmailFieldLogin(
                                controller: bloc.emailFieldController,
                                onClear: () {
                                  bloc.emailFieldController.clear();
                                  bloc.showHideEmailClearNotifier.value = false;
                                  bloc.fieldsValidations.value = false;
                                },
                                onchange: bloc.fieldValidation,
                                onEditingComplete: () => FocusManager
                                    .instance.primaryFocus
                                    ?.unfocus(),
                                showHideEmailClearNotifier:
                                    bloc.showHideEmailClearNotifier,
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
                                      enableButton: snapshot,
                                      onTap: () async {
                                        try {
                                          final navigation =
                                              Navigator.of(context);

                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          bloc.loadingStatusNotifier.value =
                                              LoadingStatus.inprogress;

                                          await bloc.doForgotPasswordCall();
                                          bloc.loadingStatusNotifier.value =
                                              LoadingStatus.finish;
                                          await navigation.pushNamed(
                                            RoutesConstants
                                                .forgotPasswordConfirmationScreen,
                                            arguments: {
                                              "email": bloc
                                                  .emailFieldController.text,
                                            },
                                          );
                                        } on ConnectionException {
                                          final scaffoldMessenger =
                                              ScaffoldMessenger.of(context);
                                          scaffoldMessenger.showSnackBar(
                                            SnackBar(
                                                content: Text(AppLocalizations
                                                        .of(context)!
                                                    .pleasecheckyourinternetconnection)),
                                          );
                                        }
                                      },
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
          }),
    );
  }
}
