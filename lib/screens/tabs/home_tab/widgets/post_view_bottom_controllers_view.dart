import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PostViewBottomControllersView extends StatelessWidget {
  final UserType currentUserType;
  final int numberOfUpRate;
  final Function() upAction;
  final Function() downAction;
  final Function() commentAction;

  const PostViewBottomControllersView({
    super.key,
    required this.currentUserType,
    required this.numberOfUpRate,
    required this.upAction,
    required this.downAction,
    required this.commentAction,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Row(
        children: [
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 239, 239, 239),
              border: Border.all(
                color: const Color.fromARGB(255, 214, 214, 214),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(50)),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => upAction(),
                  icon: Icon(
                    Icons.arrow_circle_up_rounded,
                    size: 20,
                    color: currentUserType == UserType.attorney
                        ? const Color(0xff292929)
                        : const Color(0xff034061),
                  ),
                ),
                CustomText(
                  title: AppLocalizations.of(context)!.agreedup,
                  textColor: const Color(0xff444444),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(width: 8),
                const CustomText(
                  title: "-",
                  textColor: Color(0xff444444),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(width: 8),
                CustomText(
                  title: "$numberOfUpRate",
                  textColor: const Color(0xff444444),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(width: 8),
                Container(
                  height: 39,
                  width: 1,
                  color: const Color.fromARGB(255, 214, 214, 214),
                ),
                IconButton(
                  onPressed: () => downAction(),
                  icon: Icon(
                    Icons.arrow_circle_down_rounded,
                    size: 20,
                    color: currentUserType == UserType.attorney
                        ? const Color(0xff292929)
                        : const Color(0xff034061),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          IconButton(
            onPressed: () => commentAction(),
            icon: Icon(
              Ionicons.chatbubble_ellipses_outline,
              size: 20,
              color: currentUserType == UserType.attorney
                  ? const Color(0xff292929)
                  : const Color(0xff034061),
            ),
          ),
        ],
      ),
    );
  }
}
