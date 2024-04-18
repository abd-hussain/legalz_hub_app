import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';

class CustomTabBar extends StatefulWidget {
  final TabController? tabController;
  final List<Widget> tabs;
  final UserType userType;

  const CustomTabBar(
      {super.key,
      required this.tabController,
      required this.tabs,
      required this.userType});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        SizedBox(
          height: 42,
          child: Align(
            alignment: Alignment.center,
            child: TabBar(
              indicatorColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              tabAlignment: TabAlignment.start,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xffFFFFFF)),
              labelPadding: const EdgeInsets.only(right: 21, left: 21),
              controller: widget.tabController,
              isScrollable: true,
              dividerColor: Colors.transparent,
              labelColor: const Color(0xff191C1F),
              labelStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              unselectedLabelColor: const Color(0xff8B959E),
              unselectedLabelStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              tabs: widget.tabs,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            indicator(),
            indicator(),
          ],
        )
      ],
    );
  }

  Widget indicator() {
    return ClipRect(
      child: BackdropFilter(
        blendMode: BlendMode.srcOver,
        filter: ImageFilter.blur(sigmaX: 0.7, sigmaY: 0.7),
        child: Container(
          width: 20,
          height: 50,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(color: Color(0xffF3F4F5), blurRadius: 20, spreadRadius: 1)
          ]),
        ),
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  final String tabName;

  const CustomTab({super.key, required this.tabName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: Tab(
        child: Center(
          child: CustomText(
              title: tabName, fontSize: 14, textColor: const Color(0xff191C1F)),
        ),
      ),
    );
  }
}
