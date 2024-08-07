import 'dart:io';

import 'package:flutter/material.dart';
import 'package:legalz_hub_app/models/https/categories_model.dart';
import 'package:legalz_hub_app/screens/tabs/home_tab/widgets/bottom_sheets/add_post_bottomsheet.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/routes.dart';

class HomeHeaderView extends StatefulWidget {
  const HomeHeaderView(
      {super.key,
      required this.userType,
      required this.addPost,
      required this.listOfCategories,
      required this.enableAddPost});
  final UserType userType;
  final bool enableAddPost;
  final List<Category> listOfCategories;

  final Function({required int catId, required String content, File? postImg})
      addPost;

  @override
  State<HomeHeaderView> createState() => _HomeHeaderViewState();
}

class _HomeHeaderViewState extends State<HomeHeaderView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const SizedBox(width: 8),
          if (widget.userType == UserType.attorney)
            Image.asset(
              "assets/images/logoz/logo-black.png",
              width: 100,
            )
          else
            Image.asset(
              "assets/images/logoz/logo-blue.png",
              width: 100,
            ),
          Expanded(child: const SizedBox()),
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true)
                .pushNamed(RoutesConstants.notificationsScreen),
            icon: Icon(
              Icons.notifications_none,
              color: widget.userType == UserType.attorney
                  ? const Color(0xff292929)
                  : const Color(0xff034061),
              size: 30,
            ),
          ),
          if (widget.userType == UserType.customer && widget.enableAddPost)
            IconButton(
              onPressed: () => AddPostBottomSheetsUtil().bottomSheet(
                context: context,
                categories: widget.listOfCategories,
                addPostCallback: ({required catId, required content, postImg}) {
                  widget.addPost(
                      catId: catId, content: content, postImg: postImg);
                },
              ),
              icon: Icon(
                Icons.add_circle_outline,
                color: widget.userType == UserType.attorney
                    ? const Color(0xff292929)
                    : const Color(0xff034061),
                size: 30,
              ),
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}
