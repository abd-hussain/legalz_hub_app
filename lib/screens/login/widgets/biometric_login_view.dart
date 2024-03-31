import 'package:flutter/material.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BiometrincLoginView extends StatelessWidget {
  final BiometricType? biometricType;
  final Function onPress;
  const BiometrincLoginView(
      {super.key, this.biometricType, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: Container(
                      height: 1,
                      color: const Color(0xffE8E8E8),
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  color: Colors.white,
                  width: 30,
                  child: Center(
                    child: CustomText(
                      title: AppLocalizations.of(context)!.or,
                      fontSize: 12,
                      textColor: const Color(0xff8F8F8F),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    side: const BorderSide(
                      color: Color(0xffE8E8E8),
                    ),
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: CustomText(
                      title: AppLocalizations.of(context)!.loginbiometric,
                      textColor: const Color(0xff191C1F),
                      fontSize: 14,
                    ),
                  ),
                  Image.asset(
                    (biometricType == BiometricType.face)
                        ? 'assets/images/face_id.png'
                        : 'assets/images/touch_id.png',
                    height: 30,
                    color: const Color(0xff191C1F),
                    alignment: Alignment.center,
                  ),
                ],
              ),
              onPressed: () => onPress(),
            ),
          ),
        ],
      ),
    );
  }
}
