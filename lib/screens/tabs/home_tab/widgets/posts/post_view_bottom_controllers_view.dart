import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PostViewBottomControllersView extends StatelessWidget {
  final UserType currentUserType;
  final int numberComment;

  final Function() commentAction;

  const PostViewBottomControllersView({
    super.key,
    required this.currentUserType,
    required this.numberComment,
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
                  onPressed: () => commentAction(),
                  icon: Icon(
                    Ionicons.chatbubble_ellipses_outline,
                    size: 20,
                    color: currentUserType == UserType.attorney
                        ? const Color(0xff292929)
                        : const Color(0xff034061),
                  ),
                ),
                CustomText(
                  title: AppLocalizations.of(context)!.commentsonposts,
                  textColor: const Color(0xff444444),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(width: 8),
                Container(
                  height: 39,
                  width: 1,
                  color: const Color.fromARGB(255, 214, 214, 214),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: SizedBox(
                    width: 20,
                    child: Center(
                      child: CustomText(
                        title: "$numberComment",
                        textColor: const Color(0xff444444),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
