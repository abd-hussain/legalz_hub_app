import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_text_style.dart';
import 'package:legalz_hub_app/shared_widget/date_of_birth/date_of_birth_bloc.dart';

class DateOfBirthField extends StatefulWidget {
  const DateOfBirthField({
    super.key,
    required this.language,
    required this.selectedDate,
    required this.dateSelected,
  });
  final String language;
  final String? selectedDate;
  final Function(String) dateSelected;

  @override
  State<DateOfBirthField> createState() => _DateOfBirthFieldState();
}

class _DateOfBirthFieldState extends State<DateOfBirthField> {
  final bloc = DateofBirthBloc();

  @override
  void initState() {
    if (widget.selectedDate != null) {
      bloc.dobController.text = widget.selectedDate!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: TextField(
        onTapOutside: (_) {
          bloc.focusNode.unfocus();
        },
        readOnly: true,
        autocorrect: false,
        enableSuggestions: false,
        keyboardType: TextInputType.phone,
        controller: bloc.dobController,
        cursorWidth: 1,
        cursorColor: const Color(0xff100C31),
        focusNode: bloc.focusNode,
        textAlign: TextAlign.justify,
        textAlignVertical: TextAlignVertical.center,
        style:
            CustomTextStyle().regular(color: const Color(0xff191C1F), size: 14),
        decoration: InputDecoration(
          fillColor: Colors.white,
          labelText: AppLocalizations.of(context)!.dbprofile,
          labelStyle: CustomTextStyle()
              .regular(color: const Color(0xff384048), size: 14),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffE8E8E8)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffE8E8E8)),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffE8E8E8)),
          ),
          filled: true,
        ),
        onTap: () async {
          await _showDatePicker();
        },
      ),
    );
  }

  Future<void> _showDatePicker() async {
    final DateTime? datePicked = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: bloc.dobController.text.isNotEmpty
          ? bloc.parseDate(bloc.dobController.text) ?? DateTime(2000)
          : DateTime(2000),
      firstDate: DateTime(1945),
      lastDate: DateTime(DateTime.now().year - 18),
      locale: Locale(widget.language),
      confirmText: AppLocalizations.of(context)!.ok,
      cancelText: AppLocalizations.of(context)!.cancel,
    );
    if (datePicked != null) {
      setState(() {
        bloc.format(datePicked);
        widget.dateSelected(bloc.dobController.text);
      });
    }
  }
}
