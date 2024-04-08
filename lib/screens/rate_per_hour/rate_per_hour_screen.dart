import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/screens/rate_per_hour/rate_per_hour_bloc.dart';
import 'package:legalz_hub_app/screens/rate_per_hour/widgets/hour_rate_view.dart';
import 'package:legalz_hub_app/screens/rate_per_hour/widgets/iban_view.dart';
import 'package:legalz_hub_app/shared_widget/custom_appbar.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:legalz_hub_app/shared_widget/loading_view.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';

class RatePerHourScreen extends StatefulWidget {
  const RatePerHourScreen({super.key});

  @override
  State<RatePerHourScreen> createState() => _RatePerHourScreenState();
}

class _RatePerHourScreenState extends State<RatePerHourScreen> {
  final bloc = RatePerHourBloc();

  @override
  void didChangeDependencies() {
    bloc.getHourPerRate();
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
      backgroundColor: const Color(0xffF3F4F5),
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(
        title: AppLocalizations.of(context)!.rateperhour,
        userType: UserType.attorney,
      ),
      body: ValueListenableBuilder<LoadingStatus>(
          valueListenable: bloc.loadingStatusNotifier,
          builder: (context, snapshot, child) {
            return snapshot == LoadingStatus.inprogress
                ? const LoadingView()
                : SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 16, right: 16),
                      child: Column(
                        children: [
                          HourRateView(
                            controller: bloc.ratePerHourController,
                            currency: bloc.currency,
                            freeType: bloc.freeType,
                            onTapPlus: () => bloc.encreseRatePerHourBy1(),
                            onTapMinus: () => bloc.decreseRatePerHourBy1(),
                            freeCallTypeSelected: (type) {
                              bloc.freeType = type;
                              bloc.validateFieldsForFaze5();
                            },
                          ),
                          IbanView(
                            controller: bloc.ibanController,
                            onChange: (value) {
                              bloc.validateFieldsForFaze5();
                            },
                          ),
                          const SizedBox(height: 8),
                          ValueListenableBuilder<bool>(
                              valueListenable: bloc.enableSaveButton,
                              builder: (context, snapshot, child) {
                                return CustomButton(
                                    enableButton: snapshot,
                                    onTap: () {
                                      bloc.changeRateRequest().whenComplete(() {
                                        Navigator.of(context).pop();
                                      });
                                    });
                              }),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  );
          }),
    );
  }
}
