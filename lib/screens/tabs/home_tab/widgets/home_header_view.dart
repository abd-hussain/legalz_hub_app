import 'package:flutter/material.dart';
import 'package:legalz_hub_app/screens/tabs/home_tab/widgets/add_post_bottomsheet.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/routes.dart';

class HomeHeaderView extends StatefulWidget {
  final UserType userType;
  const HomeHeaderView({super.key, required this.userType});

  @override
  State<HomeHeaderView> createState() => _HomeHeaderViewState();
}

class _HomeHeaderViewState extends State<HomeHeaderView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const SizedBox(width: 8),
          widget.userType == UserType.attorney
              ? Image.asset(
                  "assets/images/logoz/logo-black.png",
                  width: 100,
                )
              : Image.asset(
                  "assets/images/logoz/logo-blue.png",
                  width: 100,
                ),
          Expanded(child: Container()),
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
          widget.userType == UserType.customer
              ? IconButton(
                  onPressed: () =>
                      AddPostBottomSheetsUtil().bottomSheet(context),
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: widget.userType == UserType.attorney
                        ? const Color(0xff292929)
                        : const Color(0xff034061),
                    size: 30,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}