import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BioField extends StatelessWidget {
  const BioField(
      {super.key,
      required this.bioController,
      required this.onChanged,
      this.title});
  final TextEditingController bioController;
  final String? title;

  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xffe0e0e0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: bioController,
            decoration: InputDecoration(
              hintText: title ?? AppLocalizations.of(context)!.biohint,
              hintMaxLines: 2,
              hintStyle: const TextStyle(fontSize: 15),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            onChanged: onChanged,
            maxLines: 5,
            maxLength: 200,
          ),
        ),
      ),
    );
  }
}
