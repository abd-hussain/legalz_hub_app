import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legalz_hub_app/shared_widget/custom_text_style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {required this.controller,
      required this.hintText,
      this.readOnly = false,
      this.obscureText = false,
      this.enabled = true,
      this.fontSize = 14,
      this.maxLine = 1,
      this.suffixWidget,
      this.keyboardType,
      this.inputFormatters,
      this.onChange,
      this.onEditingComplete,
      this.padding = const EdgeInsets.only(left: 16, right: 16),
      this.textAlign = TextAlign.start,
      super.key});
  final TextEditingController controller;
  final String? hintText;
  final bool readOnly;
  final bool enabled;
  final bool obscureText;
  final double fontSize;
  final int maxLine;
  final EdgeInsetsGeometry padding;
  final Widget? suffixWidget;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String text)? onChange;
  final Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
          textAlign: textAlign,
          obscureText: obscureText,
          enabled: enabled,
          readOnly: readOnly,
          inputFormatters: inputFormatters,
          enableSuggestions: false,
          keyboardType: keyboardType,
          autocorrect: false,
          maxLines: maxLine,
          controller: controller,
          style: CustomTextStyle().regular(
              color:
                  enabled ? const Color(0xff191C1F) : const Color(0xffA2A3A4),
              size: fontSize),
          cursorColor: const Color(0xff100C31),
          decoration: InputDecoration(
            fillColor: enabled ? Colors.white : Colors.grey[100],
            suffix: suffixWidget,
            labelText: hintText,
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
          onChanged: (text) {
            if (onChange != null) {
              // ignore: prefer_null_aware_method_calls
              onChange!(text);
            }
          },
          onEditingComplete: () {
            if (onEditingComplete != null) {
              // ignore: prefer_null_aware_method_calls
              onEditingComplete!();
            }
          }),
    );
  }
}
