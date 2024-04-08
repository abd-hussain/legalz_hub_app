import 'package:flutter/material.dart';
import 'package:legalz_hub_app/screens/tabs/calender_tab/calender_bloc.dart';
import 'package:legalz_hub_app/screens/tabs/calender_tab/widgets/attorney_calender.dart';
import 'package:legalz_hub_app/screens/tabs/calender_tab/widgets/customer_calender.dart';
import 'package:legalz_hub_app/shared_widget/main_header_view.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/logger.dart';

class CalenderTabScreen extends StatefulWidget {
  const CalenderTabScreen({super.key});

  @override
  State<CalenderTabScreen> createState() => _CalenderTabScreenState();
}

class _CalenderTabScreenState extends State<CalenderTabScreen> {
  final bloc = CalenderBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Calender init Called ...');
    bloc.userType = bloc.box.get(DatabaseFieldConstant.userType) == "customer"
        ? UserType.customer
        : UserType.attorney;

    bloc.getAppointments(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //TODO
    return Column(
      children: [
        MainHeaderView(
          userType: bloc.userType,
          refreshCallBack: () {
            bloc.getAppointments(context);
          },
        ),
        const SizedBox(height: 8),
        Expanded(
          child: bloc.userType == UserType.attorney
              ? AttorneyCalenderView(
                  valueNotifier: bloc.attorneyAppointmentsListNotifier,
                )
              : CustomerCalenderView(
                  valueNotifier: bloc.customerAppointmentsListNotifier,
                ),
        ),
      ],
    );
  }
}
