import 'package:flutter/material.dart';
import 'package:legalz_hub_app/shared_widget/background_container.dart';
import 'package:legalz_hub_app/shared_widget/custom_appbar.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';

class ForgotPasswordConfirmationScreen extends StatefulWidget {
  const ForgotPasswordConfirmationScreen({super.key});

  @override
  State<ForgotPasswordConfirmationScreen> createState() =>
      _ForgotPasswordConfirmationScreenState();
}

class _ForgotPasswordConfirmationScreenState
    extends State<ForgotPasswordConfirmationScreen> {
  String email = "";
  @override
  void didChangeDependencies() {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      email = arguments["email"];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: AppLocalizations.of(context)!.forgotpasswordconfirmation,
        userType: UserType.customer,
      ),
      body: GestureDetector(
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
                    child: Image.asset(
                      'assets/images/reset_password_icon_lite.png',
                      height: 90,
                      width: 83,
                      alignment: Alignment.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: AppLocalizations.of(context)!
                                .forgotpasswordconfirmationtitle,
                            style: const TextStyle(
                                color: Color(0xff191C1F), fontSize: 14)),
                        TextSpan(
                          text: email,
                          style: const TextStyle(
                              color: Color(0xff191C1F),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )
                      ]),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!
                                .forgotpasswordconfirmationtitle2,
                            style: const TextStyle(
                                color: Color(0xff191C1F), fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                          text: AppLocalizations.of(context)!
                              .forgotpasswordconfirmationtitle3,
                          style: const TextStyle(
                              color: Color(0xff191C1F), fontSize: 14),
                        ),
                      ]),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: CustomText(
                      title: AppLocalizations.of(context)!
                          .forgotpasswordconfirmationtitle4,
                      fontSize: 14,
                      textColor: const Color(0xff00649A),
                    ),
                  ),
                  CustomText(
                    title: AppLocalizations.of(context)!
                        .forgotpasswordconfirmationtitle5,
                    fontSize: 14,
                    textColor: const Color(0xff191C1F),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: resetButton(context),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton resetButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context, true);
        Navigator.pop(context, true);
      },
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(
          const Color(0xff034061),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      child: CustomText(
        title: AppLocalizations.of(context)!.backtohome,
        fontSize: 16,
      ),
    );
  }
}
