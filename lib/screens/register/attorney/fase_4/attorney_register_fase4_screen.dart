import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legalz_hub_app/screens/register/attorney/fase_4/attorney_register_fase4_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/screens/register/widgets/footer_view.dart';
import 'package:legalz_hub_app/shared_widget/custom_appbar.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/shared_widget/custom_textfield.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/push_notifications/firebase_cloud_messaging_util.dart';
import 'package:legalz_hub_app/utils/routes.dart';

class AttorneyRegister4Screen extends StatefulWidget {
  const AttorneyRegister4Screen({super.key});

  @override
  State<AttorneyRegister4Screen> createState() =>
      _AttorneyRegister4ScreenState();
}

class _AttorneyRegister4ScreenState extends State<AttorneyRegister4Screen> {
  final bloc = AttorneyRegister4Bloc();

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        FirebaseCloudMessagingUtil.initConfigure(context);
      });
    });
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
        bloc.validateFieldsForFaze4();
      },
      child: Scaffold(
        appBar: customAppBar(title: ""),
        bottomNavigationBar: ValueListenableBuilder<bool>(
            valueListenable: bloc.enableNextBtn,
            builder: (context, snapshot, child) {
              return RegistrationFooterView(
                pageCount: 4,
                pageTitle: AppLocalizations.of(context)!.rateperhourtitle,
                nextPageTitle: AppLocalizations.of(context)!.setuppassword,
                enableNextButton: snapshot,
                nextPressed: () async {
                  final navigator = Navigator.of(context);
                  await bloc.box.put(
                      TempFieldToRegistrtAttorneyConstant.ratePerHour,
                      bloc.ratePerHourController.text);
                  await bloc.box.put(TempFieldToRegistrtAttorneyConstant.iban,
                      bloc.ibanController.text);

                  await bloc.box
                      .put(DatabaseFieldConstant.attorneyRegistrationStep, "6");
                  navigator
                      .pushNamed(RoutesConstants.registerAttornyFaze5Screen);
                },
              );
            }),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            bloc.validateFieldsForFaze4();
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      title: AppLocalizations.of(context)!.rateperhourdesc1,
                      fontSize: 14,
                      maxLins: 3,
                      textColor: const Color(0xff444444),
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      title: AppLocalizations.of(context)!.rateperhourdesc2,
                      fontSize: 14,
                      maxLins: 3,
                      textAlign: TextAlign.center,
                      textColor: const Color(0xff444444),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      title: AppLocalizations.of(context)!.rateperhourdesc3,
                      fontSize: 14,
                      textAlign: TextAlign.center,
                      textColor: const Color(0xff444444),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      title: "16 ${bloc.getUserCurrency()}",
                      fontSize: 16,
                      textAlign: TextAlign.center,
                      textColor: const Color(0xff444444),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.grey[200],
                            child: IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => bloc.decreseRatePerHourBy1(),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: CustomTextField(
                            controller: bloc.ratePerHourController,
                            hintText:
                                AppLocalizations.of(context)!.rateperhourtitle,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(4)
                            ],
                            fontSize: 18,
                            textAlign: TextAlign.center,
                            padding: const EdgeInsets.all(0),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.grey[200],
                            child: IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => bloc.encreseRatePerHourBy1(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      title: AppLocalizations.of(context)!.ibaninfo,
                      fontSize: 14,
                      textAlign: TextAlign.center,
                      textColor: const Color(0xff444444),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomTextField(
                    controller: bloc.ibanController,
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    hintText: "",
                    fontSize: 20,
                    keyboardType: TextInputType.name,
                    inputFormatters: [LengthLimitingTextInputFormatter(30)],
                    onChange: (text) => bloc.validateFieldsForFaze4(),
                    onEditingComplete: () =>
                        FocusManager.instance.primaryFocus?.unfocus(),
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
}
