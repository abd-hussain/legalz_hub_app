import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/screens/notifications/notifications_bloc.dart';
import 'package:legalz_hub_app/screens/notifications/widgets/list_notification_widget.dart';
import 'package:legalz_hub_app/shared_widget/custom_appbar.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/logger.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final bloc = NotificationsBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Notifications init Called ...');
    bloc.userType = bloc.box.get(DatabaseFieldConstant.userType) == "customer"
        ? UserType.customer
        : UserType.attorney;
    bloc.listOfNotifications(bloc.userType);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: AppLocalizations.of(context)!.notifications,
          userType: bloc.userType),
      body: RefreshIndicator(
        onRefresh: bloc.pullRefresh,
        child: NotificationsList(
          notificationsListNotifier: bloc.notificationsListNotifier,
        ),
      ),
    );
  }
}
