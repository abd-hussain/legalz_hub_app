import 'package:flutter/material.dart';
import 'package:legalz_hub_app/screens/tabs/home_tab/home_bloc.dart';
import 'package:legalz_hub_app/screens/tabs/home_tab/widgets/add_new_post_view.dart';
import 'package:legalz_hub_app/screens/tabs/home_tab/widgets/home_header_view.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/logger.dart';
import 'package:legalz_hub_app/utils/push_notifications/firebase_cloud_messaging_util.dart';
import 'package:legalz_hub_app/utils/push_notifications/notification_manager.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  final bloc = HomeBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Home init Called ...');
    NotificationManager.init(context: context);
    bloc.userType = bloc.box.get(DatabaseFieldConstant.userType) == "customer" ? UserType.customer : UserType.attorney;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        FirebaseCloudMessagingUtil.initConfigure(context);
      });
    });

    bloc.callRegisterTokenRequest();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //TODO
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          HomeHeaderView(userType: bloc.userType),
          const SizedBox(height: 8),
          bloc.userType == UserType.customer ? const AddNewPostView() : Container(),
        ],
      ),
    );
  }
}
