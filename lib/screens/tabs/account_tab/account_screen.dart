import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:legalz_hub_app/screens/tabs/account_tab/account_bloc.dart';
import 'package:legalz_hub_app/screens/tabs/account_tab/widgets/collection_list_option.dart';
import 'package:legalz_hub_app/screens/tabs/account_tab/widgets/footer.dart';
import 'package:legalz_hub_app/screens/tabs/account_tab/widgets/profile_header.dart';
import 'package:legalz_hub_app/screens/tabs/account_tab/widgets/title_view.dart';
import 'package:legalz_hub_app/shared_widget/admob_banner.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountTabScreen extends StatefulWidget {
  const AccountTabScreen({super.key});

  @override
  State<AccountTabScreen> createState() => _AccountTabScreenState();
}

class _AccountTabScreenState extends State<AccountTabScreen> {
  final bloc = AccountBloc();

  @override
  void didChangeDependencies() {
    logDebugMessage(message: 'Account init Called ...');
    bloc.readBiometricsInitValue();

    bloc.userType = bloc.box.get(DatabaseFieldConstant.userType) == "customer" ? UserType.customer : UserType.attorney;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileHeader(userType: bloc.userType),
        Expanded(
          child: ListView(children: [
            TitleView(title: AppLocalizations.of(context)!.accountsettings),
            CollectionListOptionView(
              listOfOptions: bloc.listOfAccountOptions(context, bloc.userType),
            ),
            TitleView(title: AppLocalizations.of(context)!.generalsettings),
            CollectionListOptionView(listOfOptions: bloc.listOfSettingsOptions(context)),
            TitleView(title: AppLocalizations.of(context)!.reachouttous),
            CollectionListOptionView(listOfOptions: bloc.listOfReachOutUsOptions(context)),
            TitleView(title: AppLocalizations.of(context)!.support),
            CollectionListOptionView(listOfOptions: bloc.listOfSupportOptions(context)),
            const SizedBox(height: 8),
            kIsWeb ? Container() : const AddMobBanner(),
            FooterView(
              language: bloc.box.get(DatabaseFieldConstant.language),
            ),
            const SizedBox(height: 8),
          ]),
        ),
      ],
    );
  }
}
