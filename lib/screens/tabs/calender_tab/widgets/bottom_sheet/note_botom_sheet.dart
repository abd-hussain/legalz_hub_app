import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class NoteBottomSheetsUtil {
  NoteBottomSheetsUtil({required this.context});
  final BuildContext context;

  Future<dynamic> showAddEditNoteDialog({
    required String note,
    required Function(String) confirm,
  }) {
    final TextEditingController controller = TextEditingController();
    controller.text = note;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: [
                      CustomText(
                        title: AppLocalizations.of(context)!.addeditnote,
                        textColor: const Color(0xff444444),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      const Expanded(child: SizedBox()),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller,
                    maxLines: 3,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.note,
                      prefixIcon: const Icon(Icons.message),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)),
                    ),
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    enableButton: true,
                    padding: const EdgeInsets.all(8),
                    buttonTitle: AppLocalizations.of(context)!.submit,
                    onTap: () {
                      Navigator.pop(context);
                      confirm(controller.text);
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        });
  }
}
