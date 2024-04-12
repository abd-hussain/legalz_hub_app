import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/models/https/notifications_response.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/shared_widget/shimmers/shimmer_notifications.dart';

class NotificationsList extends StatefulWidget {
  final ValueNotifier<List<NotificationsResponseData>?> notificationsListNotifier;
  const NotificationsList({super.key, required this.notificationsListNotifier});

  @override
  State<NotificationsList> createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<NotificationsResponseData>?>(
        valueListenable: widget.notificationsListNotifier,
        builder: (context, data, child) {
          return data == null
              ? const ShimmerNotificationsView()
              : widget.notificationsListNotifier.value!.isNotEmpty
                  ? ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (ctx, index) {
                        return notificationTile(context, data[index], index);
                      })
                  : Center(
                      child: CustomText(
                        title: AppLocalizations.of(context)!.noitem,
                        fontSize: 16,
                        textColor: const Color(0xff444444),
                      ),
                    );
        });
  }

  Widget notificationTile(BuildContext context, NotificationsResponseData item, int index) {
    var parsedDate = DateTime.parse(item.createdAt!);
    var dateLocal = parsedDate.toLocal();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Column(
                children: [
                  const Icon(
                    Icons.notifications,
                    color: Color(0xff444444),
                  ),
                  CustomText(
                    title: "${dateLocal.year}/${dateLocal.month}/${dateLocal.day}",
                    fontSize: 9,
                    textColor: const Color(0xff444444),
                  ),
                  CustomText(
                    title: "${dateLocal.hour}:${dateLocal.minute}",
                    fontSize: 9,
                    textColor: const Color(0xff444444),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: item.title!,
                    fontSize: 16,
                    textColor: const Color(0xff444444),
                    maxLins: 2,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: CustomText(
                      title: item.content!,
                      fontSize: 14,
                      textColor: const Color(0xff444444),
                      maxLins: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
