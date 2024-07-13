import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/screens/register/attorney/fase_5/attorney_register_fase5_bloc.dart';
import 'package:legalz_hub_app/screens/register/widgets/footer_view.dart';
import 'package:legalz_hub_app/shared_widget/custom_appbar.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/shared_widget/custom_textfield.dart';
import 'package:legalz_hub_app/shared_widget/email_header.dart';
import 'package:legalz_hub_app/shared_widget/password_complexity.dart';
import 'package:legalz_hub_app/shared_widget/password_field.dart';
import 'package:legalz_hub_app/shared_widget/save_password_view.dart';
import 'package:legalz_hub_app/utils/constants/constant.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/push_notifications/firebase_cloud_messaging_util.dart';
import 'package:legalz_hub_app/utils/routes.dart';

class AttorneyRegister5Screen extends StatefulWidget {
  const AttorneyRegister5Screen({super.key});

  @override
  State<AttorneyRegister5Screen> createState() =>
      _AttorneyRegister5ScreenState();
}

class _AttorneyRegister5ScreenState extends State<AttorneyRegister5Screen> {
  final bloc = AttorneyRegister5Bloc();

  @override
  void didChangeDependencies() {
    bloc.handleListeners();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        FirebaseCloudMessagingUtil.initConfigure(context);
      });
    });
    bloc.tryToFillTheFields();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        if (bloc.emailController.text.isEmpty) {
          bloc.validateEmail.value = "";
        } else {
          bloc.validateEmailMethod(context);
        }
      },
      child: Scaffold(
        appBar: customAppBar(title: "", userType: UserType.attorney),
        bottomNavigationBar: ValueListenableBuilder<bool>(
            valueListenable: bloc.enableNextBtn,
            builder: (context, snapshot, child) {
              return RegistrationFooterView(
                pageCount: 5,
                pageTitle: AppLocalizations.of(context)!.setuppassword,
                nextPageTitle: AppLocalizations.of(context)!.readytogo,
                enableNextButton: snapshot,
                nextPressed: () async {
                  final navigator = Navigator.of(context);
                  await bloc.box.put(TempFieldToRegistrtAttorneyConstant.email,
                      bloc.emailController.text);
                  await bloc.box.put(
                      TempFieldToRegistrtAttorneyConstant.password,
                      bloc.passwordController.text);

                  await bloc.box.put(DatabaseFieldConstant.saveEmailAndPassword,
                      bloc.statusOfSaveEmailAndPassword);

                  await bloc.box.put(
                      TempFieldToRegistrtAttorneyConstant.password,
                      bloc.passwordController.text);

                  await bloc.box
                      .put(DatabaseFieldConstant.attorneyRegistrationStep, "6");
                  await navigator.pushNamed(
                      RoutesConstants.registerfinalfazeScreen,
                      arguments: {AppConstant.userType: UserType.attorney});
                },
              );
            }),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const EmailHeader(),
                CustomTextField(
                  controller: bloc.emailController,
                  hintText: AppLocalizations.of(context)!.emailaddress,
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(35),
                  ],
                  onChange: (text) {
                    bloc.validateFieldsForFaze5();
                  },
                  onEditingComplete: () =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                ),
                ValueListenableBuilder<String>(
                    valueListenable: bloc.validateEmail,
                    builder: (context, snapshot, child) {
                      if (snapshot == "") {
                        return const SizedBox();
                      } else {
                        return Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: CustomText(
                                title: snapshot == ""
                                    ? AppLocalizations.of(context)!
                                        .emailformatvalid
                                    : snapshot,
                                fontSize: 12,
                                textColor:
                                    snapshot == "" ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        );
                      }
                    }),
                const SizedBox(height: 30),
                PasswordField(
                  controller: bloc.passwordController,
                  showHidePasswordClearNotifier:
                      bloc.showHidePasswordClearNotifier,
                  onClear: () {
                    bloc.passwordController.clear();
                    bloc.showHidePasswordClearNotifier.value = false;
                  },
                  onchange: bloc.validateFieldsForFaze5,
                  onEditingComplete: () =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                ),
                const SizedBox(height: 20),
                PasswordField(
                  controller: bloc.confirmPasswordController,
                  hintText: AppLocalizations.of(context)!.confirmpassword,
                  showHidePasswordClearNotifier:
                      bloc.showHideConfirmPasswordClearNotifier,
                  onClear: () {
                    bloc.confirmPasswordController.clear();
                    bloc.showHideConfirmPasswordClearNotifier.value = false;
                  },
                  onchange: bloc.validateFieldsForFaze5,
                  onEditingComplete: () =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                ),
                const SizedBox(height: 20),
                PasswordComplexity(
                  passwordEquilConfirmPasswordNotifier:
                      bloc.passwordEquilConfirmPasswordNotifier,
                  passwordHaveNumberNotifier: bloc.passwordHaveNumberNotifier,
                  passwordMoreThan8CharNotifier:
                      bloc.passwordMoreThan8CharNotifier,
                ),
                SavePasswordView(
                  selectedStatus: (val) {
                    bloc.statusOfSaveEmailAndPassword = val;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
