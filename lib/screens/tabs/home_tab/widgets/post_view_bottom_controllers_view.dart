import 'package:flutter/material.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';

class PostViewBottomControllersView extends StatelessWidget {
  final UserType currentUserType;
  final Function() upAction;
  final Function() downAction;
  final Function() commentAction;
  final Function() reportAction;

  const PostViewBottomControllersView(
      {super.key,
      required this.currentUserType,
      required this.upAction,
      required this.downAction,
      required this.commentAction,
      required this.reportAction});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Row(
        children: [
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: currentUserType == UserType.attorney ? const Color(0xff292929) : const Color(0xff034061)),
              borderRadius: const BorderRadius.all(Radius.circular(50)),
            ),
            child: Row(
              children: [],
            ),
          ),
          IconButton(
            onPressed: () => commentAction(),
            icon: Icon(
              Icons.comment_outlined,
              size: 20,
              color: currentUserType == UserType.attorney ? const Color(0xff292929) : const Color(0xff034061),
            ),
          ),
          Expanded(child: Container()),
          IconButton(
            onPressed: () => reportAction(),
            icon: Icon(
              Icons.report_gmailerrorred_rounded,
              size: 20,
              color: currentUserType == UserType.attorney ? const Color(0xff292929) : const Color(0xff034061),
            ),
          ),
        ],
      ),
    );
  }
}
