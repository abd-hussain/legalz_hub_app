import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/screens/booking_meeting/booking_bloc.dart';
import 'package:legalz_hub_app/screens/booking_meeting/widgets/item_in_gred.dart';

class MeetingTimingView extends StatelessWidget {
  const MeetingTimingView({
    super.key,
    required this.date,
    required this.time,
    required this.duration,
    required this.type,
    this.padding = const EdgeInsets.only(top: 8, left: 16, right: 16),
  });
  final String? date;
  final String? time;
  final String? duration;
  final BookingType? type;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          childAspectRatio: 3.2,
        ),
        children: [
          ItemInGrid(
            title: AppLocalizations.of(context)!.eventday,
            value: date,
          ),
          ItemInGrid(
            title: AppLocalizations.of(context)!.meetingtime,
            value: time,
          ),
          ItemInGrid(
              title: AppLocalizations.of(context)!.meetingduration,
              value: duration != null
                  ? "$duration ${AppLocalizations.of(context)!.min}"
                  : null),
          ItemInGrid(
              title: AppLocalizations.of(context)!.appointmenttype,
              value: type == BookingType.schudule
                  ? AppLocalizations.of(context)!.schudule
                  : AppLocalizations.of(context)!.instant),
        ],
      ),
    );
  }
}
