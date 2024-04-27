import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/models/https/working_hour_request.dart';
import 'package:legalz_hub_app/models/working_hours.dart';
import 'package:legalz_hub_app/screens/working_hours/widgets/info_working_hour_bottomsheet.dart';
import 'package:legalz_hub_app/screens/working_hours/working_hours_bloc.dart';
import 'package:legalz_hub_app/shared_widget/custom_appbar.dart';
import 'package:legalz_hub_app/shared_widget/edit_working_hour_bottomsheet.dart';
import 'package:legalz_hub_app/shared_widget/loading_view.dart';
import 'package:legalz_hub_app/shared_widget/working_hours.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/day_time.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';

class WorkingHoursScreen extends StatefulWidget {
  const WorkingHoursScreen({super.key});

  @override
  State<WorkingHoursScreen> createState() => _WorkingHoursScreenState();
}

class _WorkingHoursScreenState extends State<WorkingHoursScreen> {
  final bloc = WorkingHoursBloc();

  @override
  void didChangeDependencies() {
    bloc.getWorkingHours(context);
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
        title: AppLocalizations.of(context)!.workinghour,
        userType: UserType.attorney,
        actions: [
          IconButton(
            onPressed: () => InfoWorkingHourBottomSheetsUtil().info(context),
            icon: const Icon(Icons.info),
          )
        ],
      ),
      body: ValueListenableBuilder<LoadingStatus>(
          valueListenable: bloc.loadingStatusNotifier,
          builder: (context, snapshot, child) {
            return snapshot == LoadingStatus.inprogress
                ? const LoadingView()
                : ValueListenableBuilder<List<WorkingHourModel>>(
                    valueListenable: bloc.listOfWorkingHourNotifier,
                    builder: (context, snapshot, child) {
                      return ListView.builder(
                          itemCount:
                              bloc.listOfWorkingHourNotifier.value.length,
                          itemBuilder: (context, index) {
                            return WorkingHoursWidget(
                              workingHours: bloc
                                  .listOfWorkingHourNotifier.value[index].list,
                              dayName: bloc.box.get(
                                          DatabaseFieldConstant.language) !=
                                      "ar"
                                  ? bloc.listOfWorkingHourNotifier.value[index]
                                      .dayName
                                  : DayTime().convertDayToArabic(bloc
                                      .listOfWorkingHourNotifier
                                      .value[index]
                                      .dayName),
                              onSave: () {
                                EditWorkingHourBottomSheetsUtil().workingHour(
                                  context: context,
                                  dayname: bloc.box.get(
                                              DatabaseFieldConstant.language) !=
                                          "ar"
                                      ? bloc.listOfWorkingHourNotifier
                                          .value[index].dayName
                                      : DayTime().convertDayToArabic(bloc
                                          .listOfWorkingHourNotifier
                                          .value[index]
                                          .dayName),
                                  listOfWorkingHour: bloc
                                      .listOfWorkingHourNotifier
                                      .value[index]
                                      .list,
                                  onSave: (newList) async {
                                    await bloc
                                        .updateWorkingHours(
                                            context: context,
                                            obj: WorkingHoursRequest(
                                              dayName: bloc
                                                  .listOfWorkingHourNotifier
                                                  .value[index]
                                                  .dayName,
                                              workingHours: newList,
                                            ))
                                        .whenComplete(() {
                                      bloc.loadingStatusNotifier.value =
                                          LoadingStatus.finish;
                                      bloc.getWorkingHours(context);
                                    });
                                  },
                                );
                              },
                            );
                          });
                    });
          }),
    );
  }
}
