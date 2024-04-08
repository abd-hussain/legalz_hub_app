import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/screens/invite_friends/invite_friends_bloc.dart';
import 'package:legalz_hub_app/screens/invite_friends/widgets/client_share_view.dart';
import 'package:legalz_hub_app/screens/invite_friends/widgets/mentor_share_view.dart';
import 'package:legalz_hub_app/shared_widget/custom_appbar.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';

class InviteFriendsScreen extends StatefulWidget {
  const InviteFriendsScreen({super.key});

  @override
  State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
  final _bloc = InviteFriendsBloc();

  @override
  void didChangeDependencies() {
    _bloc.fetchContacts();

    _bloc.userType = _bloc.box.get(DatabaseFieldConstant.userType) == "customer"
        ? UserType.customer
        : UserType.attorney;

    _bloc.getProfileInformations();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: AppLocalizations.of(context)!.invite_friends,
          userType: _bloc.userType),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ValueListenableBuilder<String>(
                valueListenable: _bloc.invitationCodeNotifier,
                builder: (context, snapshot, child) {
                  return Column(
                    children: [
                      MentorShareView(invitationCode: snapshot),
                      const SizedBox(height: 10),
                      ClientShareView(invitationCode: snapshot),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
