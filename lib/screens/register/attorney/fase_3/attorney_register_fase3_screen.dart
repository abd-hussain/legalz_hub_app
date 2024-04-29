import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/models/working_hours.dart';
import 'package:legalz_hub_app/screens/register/attorney/fase_3/attorney_register_fase3_bloc.dart';
import 'package:legalz_hub_app/screens/register/widgets/footer_view.dart';
import 'package:legalz_hub_app/shared_widget/custom_appbar.dart';
import 'package:legalz_hub_app/shared_widget/edit_working_hour_bottomsheet.dart';
import 'package:legalz_hub_app/shared_widget/working_hours.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/routes.dart';

class AttorneyRegister3Screen extends StatefulWidget {
  const AttorneyRegister3Screen({super.key});

  @override
  State<AttorneyRegister3Screen> createState() =>
      _AttorneyRegister3ScreenState();
}

class _AttorneyRegister3ScreenState extends State<AttorneyRegister3Screen> {
  final bloc = AttorneyRegister3Bloc();

  @override
  void didChangeDependencies() {
    bloc.fillListOfWorkingHourNotifier(context);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "", userType: UserType.attorney),
      bottomNavigationBar: ValueListenableBuilder<bool>(
          valueListenable: bloc.enableNextBtn,
          builder: (context, snapshot, child) {
            return RegistrationFooterView(
              pageCount: 3,
              pageTitle: AppLocalizations.of(context)!.workinghour,
              nextPageTitle: AppLocalizations.of(context)!.rateperhourtitle,
              enableNextButton: snapshot,
              nextPressed: () async {
                final navigator = Navigator.of(context);
                final localization = AppLocalizations.of(context)!;
                await bloc.box.put(
                    TempFieldToRegistrtAttorneyConstant.saturdayWH,
                    bloc.filterListOfTiming(dayName: localization.saturday));
                await bloc.box.put(TempFieldToRegistrtAttorneyConstant.sundayWH,
                    bloc.filterListOfTiming(dayName: localization.sunday));
                await bloc.box.put(TempFieldToRegistrtAttorneyConstant.mondayWH,
                    bloc.filterListOfTiming(dayName: localization.monday));
                await bloc.box.put(
                    TempFieldToRegistrtAttorneyConstant.tuesdayWH,
                    bloc.filterListOfTiming(dayName: localization.tuesday));
                await bloc.box.put(
                    TempFieldToRegistrtAttorneyConstant.wednesdayWH,
                    bloc.filterListOfTiming(dayName: localization.wednesday));
                await bloc.box.put(
                    TempFieldToRegistrtAttorneyConstant.thursdayWH,
                    bloc.filterListOfTiming(dayName: localization.thursday));
                await bloc.box.put(TempFieldToRegistrtAttorneyConstant.fridayWH,
                    bloc.filterListOfTiming(dayName: localization.friday));

                await bloc.box
                    .put(DatabaseFieldConstant.attorneyRegistrationStep, "4");
                await navigator
                    .pushNamed(RoutesConstants.registerAttornyFaze4Screen);
              },
            );
          }),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          bloc.validateFieldsForFaze3();
        },
        child: ValueListenableBuilder<List<WorkingHourModel>>(
            valueListenable: bloc.listOfWorkingHourNotifier,
            builder: (context, snapshot, child) {
              return ListView.builder(
                  itemCount: bloc.listOfWorkingHourNotifier.value.length,
                  itemBuilder: (context, index) {
                    return WorkingHoursWidget(
                      workingHours:
                          bloc.listOfWorkingHourNotifier.value[index].list,
                      dayName:
                          bloc.listOfWorkingHourNotifier.value[index].dayName,
                      onSave: () {
                        EditWorkingHourBottomSheetsUtil().workingHour(
                          context: context,
                          dayname: bloc
                              .listOfWorkingHourNotifier.value[index].dayName,
                          listOfWorkingHour:
                              bloc.listOfWorkingHourNotifier.value[index].list,
                          onSave: (newList) {
                            bloc.listOfWorkingHourNotifier.value[index] =
                                WorkingHourModel(
                                    list: bloc.prepareList(context, newList),
                                    dayName: bloc.listOfWorkingHourNotifier
                                        .value[index].dayName);

                            bloc.validateFieldsForFaze3();
                            setState(() {});
                          },
                        );
                      },
                    );
                  });
            }),
      ),
    );
  }
}
