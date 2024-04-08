import 'package:flutter/material.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FreeCallSegmentedView extends StatelessWidget {
  final int freeType;
  final Function(int) freeCallTypeSelected;
  const FreeCallSegmentedView(
      {super.key, required this.freeType, required this.freeCallTypeSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: CustomText(
            title: AppLocalizations.of(context)!.enablefreecall,
            fontSize: 16,
            textAlign: TextAlign.center,
            textColor: const Color(0xff444444),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: CustomText(
            title: AppLocalizations.of(context)!.enablefreecalldesc,
            fontSize: 12,
            maxLins: 4,
            textAlign: TextAlign.center,
            textColor: const Color(0xff444444),
          ),
        ),
        FreeOptions(
          freeType: checkValue(freeType),
          freeCallTypeSelected: (val) {
            freeCallTypeSelected(val);
          },
        ),
      ],
    );
  }

  FreeCallTypes checkValue(int index) {
    if (index == 1) {
      return FreeCallTypes.freeDisabled;
    } else if (index == 2) {
      return FreeCallTypes.free15Min;
    } else if (index == 3) {
      return FreeCallTypes.free15MinWithPromocode;
    } else {
      return FreeCallTypes.nothing;
    }
  }
}

enum FreeCallTypes { freeDisabled, free15Min, free15MinWithPromocode, nothing }

class FreeOptions extends StatefulWidget {
  final FreeCallTypes freeType;
  final Function(int) freeCallTypeSelected;

  const FreeOptions(
      {super.key, required this.freeType, required this.freeCallTypeSelected});

  @override
  State<FreeOptions> createState() => _FreeOptionsState();
}

class _FreeOptionsState extends State<FreeOptions> {
  late Set<FreeCallTypes> selectedAccessories;

  @override
  void initState() {
    selectedAccessories = <FreeCallTypes>{widget.freeType};
    super.initState();
  }

  int getValue(FreeCallTypes value) {
    if (value == FreeCallTypes.freeDisabled) {
      return 1;
    } else if (value == FreeCallTypes.free15Min) {
      return 2;
    } else if (value == FreeCallTypes.free15MinWithPromocode) {
      return 3;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<FreeCallTypes>(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((Set<MaterialState> states) {
          return states.contains(MaterialState.selected)
              ? const Color(0xff034061)
              : Colors.white;
        }),
        foregroundColor:
            MaterialStateColor.resolveWith((Set<MaterialState> states) {
          return states.contains(MaterialState.selected)
              ? Colors.white
              : const Color(0xff034061);
        }),
      ),
      selected: selectedAccessories,
      showSelectedIcon: false,
      selectedIcon: const Icon(Icons.check_circle),
      onSelectionChanged: (Set<FreeCallTypes> newSelection) {
        setState(() {
          selectedAccessories = newSelection;

          widget.freeCallTypeSelected(getValue(selectedAccessories.first));
        });
      },
      segments: <ButtonSegment<FreeCallTypes>>[
        ButtonSegment<FreeCallTypes>(
          value: FreeCallTypes.freeDisabled,
          label: Text(
            AppLocalizations.of(context)!.disable,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          icon: const Icon(Icons.phone_disabled_sharp),
        ),
        ButtonSegment<FreeCallTypes>(
          value: FreeCallTypes.free15Min,
          label: Text(
            AppLocalizations.of(context)!.freeforall,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          icon: const Icon(Icons.free_cancellation_outlined),
        ),
        ButtonSegment<FreeCallTypes>(
          value: FreeCallTypes.free15MinWithPromocode,
          label: Text(
            AppLocalizations.of(context)!.freewithpromo,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          icon: const Icon(Icons.code),
        ),
      ],
    );
  }
}
