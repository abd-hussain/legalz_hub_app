import 'package:flutter/material.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/routes.dart';

class MainHeaderView extends StatefulWidget {
  const MainHeaderView(
      {required this.userType, super.key, this.refreshCallBack});
  final UserType userType;

  final Function()? refreshCallBack;

  @override
  State<MainHeaderView> createState() => _MainHeaderViewState();
}

class _MainHeaderViewState extends State<MainHeaderView> {
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
          if (widget.refreshCallBack != null)
            IconButton(
              onPressed: () => widget.refreshCallBack!(),
              icon: Icon(
                Icons.refresh,
                color: widget.userType == UserType.attorney
                    ? const Color(0xff292929)
                    : const Color(0xff034061),
                size: 30,
              ),
            )
          else
            Container(),
        ],
      ),
    );
  }
}
