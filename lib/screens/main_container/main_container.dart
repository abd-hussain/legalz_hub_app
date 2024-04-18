import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/main_context.dart';
import 'package:legalz_hub_app/screens/main_container/main_container_bloc.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});
  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  final _bloc = locator<MainContainerBloc>();

  @override
  void initState() {
    locator<MainContext>().mainContext = context;
    _bloc.getlistOfCategories(context);

    _bloc.userType = _bloc.box.get(DatabaseFieldConstant.userType) == "customer"
        ? UserType.customer
        : UserType.attorney;

    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6F7),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: _bloc.userType == UserType.customer
            ? const Color(0xff034061)
            : const Color(0xff292929),
      ),
      body: SafeArea(
          child: _bloc.userType == UserType.attorney
              ? ValueListenableBuilder<AttorneySelectedTab>(
                  valueListenable: _bloc.attornyCurrentTabIndexNotifier,
                  builder: (context, data, child) {
                    return IndexedStack(
                      index: _bloc.getAttorneySelectedIndexDependOnTab(data),
                      children: _bloc.attornyNavTabs,
                    );
                  })
              : ValueListenableBuilder<CustomerSelectedTab>(
                  valueListenable: _bloc.customerCurrentTabIndexNotifier,
                  builder: (context, data, child) {
                    return IndexedStack(
                      index: _bloc.getCustomerSelectedIndexDependOnTab(data),
                      children: _bloc.customerNavTabs,
                    );
                  })),
      bottomNavigationBar: ConvexAppBar(
        initialActiveIndex: 0,
        key: _bloc.appBarKey,
        backgroundColor: Colors.white,
        activeColor: const Color(0xff4CB6EA),
        color: const Color(0xff444444),
        cornerRadius: 8,
        height: 60,
        style: TabStyle.fixedCircle,
        items: _bloc.userType == UserType.attorney
            ? _bloc.attorneyItems(context)
            : _bloc.customerItems(context),
        onTap: (int index) {
          if (_bloc.userType == UserType.attorney) {
            _bloc.attornyCurrentTabIndexNotifier.value =
                _bloc.returnAttornySelectedtypeDependOnIndex(index);
          } else {
            _bloc.customerCurrentTabIndexNotifier.value =
                _bloc.returnCustomerSelectedtypeDependOnIndex(index);
          }
        },
      ),
    );
  }
}
