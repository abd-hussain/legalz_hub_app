import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/utils/day_time.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/routes.dart';

class ProfileHeader extends StatelessWidget {
  final UserType userType;
  const ProfileHeader({required this.userType, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: userType == UserType.customer
          ? const Color(0xff034061)
          : const Color(0xff292929),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(
          children: [
            Image.asset(
                locator<DayTime>().gettheCorrentImageDependOnCurrentTime(),
                width: 32,
                height: 32),
            const SizedBox(width: 8),
            Expanded(
              child: CustomText(
                title: AppLocalizations.of(context)!.welcomeback,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
                onPressed: () => Navigator.of(context, rootNavigator: true)
                    .pushNamed(RoutesConstants.notificationsScreen),
                icon: const Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                  size: 30,
                ))
          ],
        ),
      ),
    );
  }
}
