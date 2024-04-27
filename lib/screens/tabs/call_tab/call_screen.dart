import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:legalz_hub_app/models/https/attorney_appointment.dart';
import 'package:legalz_hub_app/models/https/customer_appointment.dart';
import 'package:legalz_hub_app/screens/tabs/call_tab/call_bloc.dart';
import 'package:legalz_hub_app/screens/tabs/call_tab/widgets/call_ready_view.dart';
import 'package:legalz_hub_app/screens/tabs/call_tab/widgets/no_call_view.dart';
import 'package:legalz_hub_app/screens/tabs/call_tab/widgets/waiting_call_view.dart';
import 'package:legalz_hub_app/shared_widget/main_header_view.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/day_time.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/logger.dart';

class CallTabScreen extends StatefulWidget {
  const CallTabScreen({super.key});

  @override
  State<CallTabScreen> createState() => _CallTabScreenState();
}

class _CallTabScreenState extends State<CallTabScreen> {
  final bloc = CallBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Call init Called ...');
    bloc.userType = bloc.box.get(DatabaseFieldConstant.userType) == "customer"
        ? UserType.customer
        : UserType.attorney;
    bloc.getActiveAppointments();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MainHeaderView(
          userType: bloc.userType,
          refreshCallBack: () {
            bloc.getActiveAppointments();
          },
        ),
        Expanded(
          child: SingleChildScrollView(
            child: bloc.userType == UserType.attorney
                ? ValueListenableBuilder<List<AttorneyAppointmentsData>>(
                    valueListenable:
                        bloc.activeAttorneyAppointmentsListNotifier,
                    builder: (context, snapshot, child) {
                      if (snapshot.isEmpty) {
                        return noCallView();
                      }

                      final appointment =
                          bloc.getNearestAttorneyMeetingToday(snapshot);

                      if (appointment == null) {
                        return noCallView();
                      }

                      final DateTime now = DateTime.now();
                      final DateTime timeDifference =
                          DateTime.parse(appointment.dateFrom!).isAfter(now)
                              ? DateTime.parse(appointment.dateFrom!)
                                  .subtract(Duration(
                                  hours: now.hour,
                                  minutes: now.minute,
                                  seconds: now.second,
                                ))
                              : DateTime(now.year, now.month, now.day);

                      if (bloc.isTimeDifferencePositive(timeDifference)) {
                        return WaitingCallView(
                          timerStartNumberHour: timeDifference.hour,
                          timerStartNumberMin: timeDifference.minute,
                          timerStartNumberSec: timeDifference.second,
                          attorneyMetingDetails: appointment,
                          customerMetingDetails: null,
                          userType: UserType.attorney,
                          meetingtime: DateFormat('hh:mm a')
                              .format(DateTime.parse(appointment.dateFrom!)),
                          meetingduration:
                              "${DateTime.parse(appointment.dateTo!).difference(DateTime.parse(appointment.dateFrom!)).inMinutes}",
                          meetingday: bloc.box
                                      .get(DatabaseFieldConstant.language) ==
                                  "en"
                              ? DateFormat('EEEE').format(timeDifference)
                              : DayTime().convertDayToArabic(
                                  DateFormat('EEEE').format(timeDifference)),
                          cancelMeetingTapped: () {
                            bloc
                                .cancelAppointment(id: appointment.id!)
                                .then((value) async {
                              bloc.getActiveAppointments();
                            });
                          },
                          timesup: () {
                            setState(() {});
                          },
                        );
                      }

                      if (bloc.chechIfUserNotExiedTheTimeAllowedToEnter(
                          appointmentFromDate:
                              DateTime.parse(appointment.dateFrom!))) {
                        return CallReadyView(
                          channelId: appointment.channelId!,
                          appointmentId: appointment.id!,
                          userType: UserType.attorney,
                          meetingDurationInMin: DateTime.parse(
                                  appointment.dateTo!)
                              .difference(DateTime.parse(appointment.dateFrom!))
                              .inMinutes,
                          callEnd: () {
                            bloc.getActiveAppointments();
                          },
                        );
                      } else {
                        return noCallView();
                      }
                    })
                : ValueListenableBuilder<List<CustomerAppointmentData>>(
                    valueListenable:
                        bloc.activeCustomerAppointmentsListNotifier,
                    builder: (context, snapshot, child) {
                      if (snapshot.isEmpty) {
                        return noCallView();
                      }

                      final appointment =
                          bloc.getNearestCustomerMeetingToday(snapshot);

                      if (appointment == null) {
                        return noCallView();
                      }

                      final DateTime now = DateTime.now();
                      final DateTime timeDifference =
                          DateTime.parse(appointment.dateFrom!).isAfter(now)
                              ? DateTime.parse(appointment.dateFrom!)
                                  .subtract(Duration(
                                  hours: now.hour,
                                  minutes: now.minute,
                                  seconds: now.second,
                                ))
                              : DateTime(now.year, now.month, now.day);

                      if (bloc.isTimeDifferencePositive(timeDifference)) {
                        return WaitingCallView(
                          timerStartNumberHour: timeDifference.hour,
                          timerStartNumberMin: timeDifference.minute,
                          timerStartNumberSec: timeDifference.second,
                          attorneyMetingDetails: null,
                          customerMetingDetails: appointment,
                          userType: UserType.customer,
                          meetingtime: DateFormat('hh:mm a')
                              .format(DateTime.parse(appointment.dateFrom!)),
                          meetingduration:
                              "${DateTime.parse(appointment.dateTo!).difference(DateTime.parse(appointment.dateFrom!)).inMinutes}",
                          meetingday: bloc.box
                                      .get(DatabaseFieldConstant.language) ==
                                  "en"
                              ? DateFormat('EEEE').format(timeDifference)
                              : DayTime().convertDayToArabic(
                                  DateFormat('EEEE').format(timeDifference)),
                          cancelMeetingTapped: () {
                            bloc
                                .cancelAppointment(id: appointment.id!)
                                .then((value) async {
                              bloc.getActiveAppointments();
                            });
                          },
                          timesup: () {
                            setState(() {});
                          },
                        );
                      }

                      if (bloc.chechIfUserNotExiedTheTimeAllowedToEnter(
                          appointmentFromDate:
                              DateTime.parse(appointment.dateFrom!))) {
                        return CallReadyView(
                          channelId: appointment.channelId!,
                          appointmentId: appointment.id!,
                          userType: UserType.customer,
                          meetingDurationInMin: DateTime.parse(
                                  appointment.dateTo!)
                              .difference(DateTime.parse(appointment.dateFrom!))
                              .inMinutes,
                          callEnd: () {
                            bloc.getActiveAppointments();
                          },
                        );
                      } else {
                        return noCallView();
                      }
                    }),
          ),
        ),
      ],
    );
  }

  Widget noCallView() {
    if (bloc.userType == UserType.attorney) {
      return NoCallView(
        language: bloc.box.get(DatabaseFieldConstant.language),
        userType: bloc.userType,
        listOfCategories: const [],
        refreshThePage: () {},
      );
    } else {
      return FutureBuilder(
        future: bloc.listOfCategories(),
        builder: (context, categoriesSnapShot) {
          return NoCallView(
            language: bloc.box.get(DatabaseFieldConstant.language),
            userType: bloc.userType,
            listOfCategories: categoriesSnapShot.data ?? [],
            refreshThePage: () {
              bloc.getActiveAppointments();
            },
          );
        },
      );
    }
  }
}
