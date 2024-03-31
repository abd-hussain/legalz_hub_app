import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomButton extends StatelessWidget {
  final String buttonTitle;
  final Color buttonTitleColor;

  final bool enableButton;
  final Color buttonColor;
  final Function() onTap;
  final double? width;
  final EdgeInsetsGeometry padding;

  const CustomButton({
    this.buttonTitle = "Submit",
    this.buttonTitleColor = Colors.black,
    required this.enableButton,
    this.width,
    this.buttonColor = const Color(0xff4CB6EA),
    required this.onTap,
    super.key,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                enableButton ? buttonColor : const Color(0xffB1B1B1))),
        onPressed: () => enableButton ? onTap() : null,
        child: SizedBox(
          height: 45,
          width: width,
          child: Center(
            child: Text(
              buttonTitle == "Submit"
                  ? AppLocalizations.of(context)!.submit
                  : buttonTitle,
              style: TextStyle(color: buttonTitleColor),
            ),
          ),
        ),
      ),
    );
  }
}
