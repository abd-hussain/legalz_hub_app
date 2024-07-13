import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/screens/login/login_screen.dart';
import 'package:legalz_hub_app/screens/register/final_stage/register_final_bloc.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/shared_widget/loading_view.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/error/exceptions.dart';
import 'package:legalz_hub_app/utils/push_notifications/firebase_cloud_messaging_util.dart';
import 'package:lottie/lottie.dart';

class RegisterFinalScreen extends StatefulWidget {
  const RegisterFinalScreen({super.key});

  @override
  State<RegisterFinalScreen> createState() => _RegisterFinalScreenState();
}

class _RegisterFinalScreenState extends State<RegisterFinalScreen> {
  final bloc = RegisterFinalBloc();

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        FirebaseCloudMessagingUtil.initConfigure(context);
      });
    });

    bloc.handleReadingArguments(
        arguments: ModalRoute.of(context)!.settings.arguments);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ValueListenableBuilder<LoadingStatus>(
            valueListenable: bloc.loadingStatus,
            builder: (context, snapshot, child) {
              return Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/lottie/animation_lm3q2kl2.zip',
                          width: MediaQuery.of(context).size.width - 16),
                      CustomText(
                        title: AppLocalizations.of(context)!.createprofile,
                        fontSize: 22,
                        textColor: const Color(0xff444444),
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        title: AppLocalizations.of(context)!.createprofiledesc,
                        fontSize: 16,
                        textColor: const Color(0xff444444),
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                          enableButton: true,
                          onTap: () async {
                            final scaffoldMessenger =
                                ScaffoldMessenger.of(context);
                            final navigation = Navigator.of(context);
                            final localization = AppLocalizations.of(context)!;
                            bloc.loadingStatus.value = LoadingStatus.inprogress;

                            if (bloc.userType == UserType.attorney) {
                              try {
                                await bloc
                                    .handleCreatingTheAttorneyProfile(context)
                                    .then((value) async {
                                  bloc.loadingStatus.value =
                                      LoadingStatus.finish;
                                  scaffoldMessenger.showSnackBar(
                                    SnackBar(
                                      content: Text(localization
                                          .accountcreatedsuccessfully),
                                    ),
                                  );
                                  await bloc.box.put(
                                      DatabaseFieldConstant.biometricU,
                                      bloc.box.get(
                                          TempFieldToRegistrtAttorneyConstant
                                              .email));
                                  await bloc.box.put(
                                      DatabaseFieldConstant.biometricP,
                                      bloc.box.get(
                                          TempFieldToRegistrtAttorneyConstant
                                              .password));
                                  await bloc.clearAttorneyRegistrationData();

                                  await navigation.pushReplacement(
                                      MaterialPageRoute(builder: (ctx) {
                                    return const LoginScreen();
                                  }));
                                });
                              } on DioException catch (e) {
                                final error = e.error! as HttpException;
                                bloc.loadingStatus.value = LoadingStatus.finish;
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(
                                    content: Text(error.message),
                                  ),
                                );
                              }
                            } else {
                              try {
                                await bloc
                                    .handleCreatingTheCustomerProfile(context)
                                    .then((value) async {
                                  bloc.loadingStatus.value =
                                      LoadingStatus.finish;
                                  scaffoldMessenger.showSnackBar(
                                    SnackBar(
                                      content: Text(localization
                                          .accountcreatedsuccessfully),
                                    ),
                                  );
                                  await bloc.box.put(
                                      DatabaseFieldConstant.biometricU,
                                      bloc.box.get(
                                          TempFieldToRegistrtCustomerConstant
                                              .email));
                                  await bloc.box.put(
                                      DatabaseFieldConstant.biometricP,
                                      bloc.box.get(
                                          TempFieldToRegistrtCustomerConstant
                                              .password));
                                  await bloc.clearCustomerRegistrationData();

                                  await navigation.pushReplacement(
                                      MaterialPageRoute(builder: (ctx) {
                                    return const LoginScreen();
                                  }));
                                });
                              } on DioException catch (e) {
                                final error = e.error! as HttpException;
                                bloc.loadingStatus.value = LoadingStatus.finish;
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(
                                    content: Text(error.message),
                                  ),
                                );
                              }
                            }
                          }),
                    ],
                  ),
                  if (snapshot == LoadingStatus.inprogress)
                    const LoadingView(fullScreen: true)
                  else
                    const SizedBox(),
                ],
              );
            }),
      ),
    );
  }
}
