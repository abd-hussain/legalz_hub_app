import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/locator.dart';
import 'package:legalz_hub_app/models/https/contact_list_upload.dart';
import 'package:legalz_hub_app/services/attorney/attorney_account_service.dart';
import 'package:legalz_hub_app/services/customer/customer_account_service.dart';
import 'package:legalz_hub_app/services/settings_service.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/mixins.dart';

class InviteFriendsBloc extends Bloc<SettingService> {
  ValueNotifier<String> invitationCodeNotifier = ValueNotifier<String>("");

  final box = Hive.box(DatabaseBoxConstant.userInfo);
  UserType userType = UserType.customer;

  Future fetchContacts() async {
    if (await FlutterContacts.requestPermission(readonly: true)) {
      await uploadContactsListToServer(
        await FlutterContacts.getContacts(
            withProperties: true, withPhoto: true),
      );
    }
  }

  Future<void> uploadContactsListToServer(List<Contact> contatctList) async {
    final listOfContacts = UploadContact(list: []);

    for (final item in contatctList) {
      final String contactName = item.displayName != ""
          ? item.displayName
          : ("${item.name.first} ${item.name.last}");
      final String phoneNumber =
          item.phones.isNotEmpty ? item.phones[0].number : "";
      final String email = item.emails.isNotEmpty ? item.emails[0].address : "";

      if (userType == UserType.attorney) {
        listOfContacts.list.add(
          MyContact(
            fullName: contactName,
            mobileNumber: phoneNumber.replaceAll(" ", ""),
            email: email,
            attorneyOwnerId: box.get(DatabaseFieldConstant.userid),
          ),
        );
      } else {
        listOfContacts.list.add(
          MyContact(
            fullName: contactName,
            mobileNumber: phoneNumber.replaceAll(" ", ""),
            email: email,
            customersOwnerId: box.get(DatabaseFieldConstant.userid),
          ),
        );
      }
    }
    if (listOfContacts.list.isNotEmpty) {
      await service.uploadContactList(contacts: listOfContacts);
    }
  }

  Future<void> getProfileInformations() async {
    if (userType == UserType.attorney) {
      await locator<AttorneyAccountService>().getProfileInfo().then((value) {
        final data = value.data;
        if (data != null) {
          invitationCodeNotifier.value = data.invitationCode ?? "";
        }
      });
    } else {
      await locator<CustomerAccountService>()
          .getCustomerAccountInfo()
          .then((value) {
        final data = value.data;
        if (data != null) {
          invitationCodeNotifier.value = data.invitationCode ?? "";
        }
      });
    }
  }

  @override
  void onDispose() {
    invitationCodeNotifier.dispose();
  }
}
