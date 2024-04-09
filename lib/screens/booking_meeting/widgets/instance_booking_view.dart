import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/models/https/attorney_info_avaliable_model.dart';
import 'package:legalz_hub_app/screens/booking_meeting/widgets/founded_attorney_info.dart';
import 'package:legalz_hub_app/screens/booking_meeting/widgets/serching_for_attorney_view.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class InstanceBookingView extends StatefulWidget {
  final String? categoryName;
  final ValueNotifier<List<AttorneyInfoAvaliableResponseData>?>
      avaliableAttornies;
  final Function(AttorneyInfoAvaliableResponseData) onSelectAttorney;

  const InstanceBookingView({
    super.key,
    required this.avaliableAttornies,
    required this.categoryName,
    required this.onSelectAttorney,
  });

  @override
  State<InstanceBookingView> createState() => _InstanceBookingViewState();
}

class _InstanceBookingViewState extends State<InstanceBookingView> {
  int selectedMentorIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: CustomText(
              title: "-- ${AppLocalizations.of(context)!.selectmentor} --",
              fontSize: 16,
              textColor: const Color(0xff554d56),
            ),
          ),
          ValueListenableBuilder<List<AttorneyInfoAvaliableResponseData>?>(
              valueListenable: widget.avaliableAttornies,
              builder: (context, snapshot, child) {
                if (snapshot == null) {
                  return const SearchForAttorneyView();
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 190,
                      child: ListView.builder(
                          itemCount: snapshot.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width - 100,
                              child: FoundedAttorneyInfoView(
                                data: snapshot[index],
                                selected: selectedMentorIndex == index,
                                onPress: () {
                                  selectedMentorIndex = index;
                                  widget.onSelectAttorney(snapshot[index]);
                                  setState(() {});
                                },
                              ),
                            );
                          }),
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
