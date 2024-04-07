import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/models/https/contact_list_upload.dart';
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
      uploadContactsListToServer(await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true));
    }
  }

  Future<void> uploadContactsListToServer(List<Contact> contatctList) async {
    var listOfContacts = UploadContact(list: []);

    for (var item in contatctList) {
      String contactName = item.displayName != ""
          ? item.displayName
          : ("${item.name.first} ${item.name.last}");
      String phoneNumber = item.phones.isNotEmpty ? item.phones[0].number : "";
      String email = item.emails.isNotEmpty ? item.emails[0].address : "";

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

  void getProfileInformations() async {
    //TODO
    if (userType == UserType.attorney) {
      // locator<AccountService>().getProfileInfo().then((value) {
      //   final data = value.data;

      //   if (data != null) {
      //     invitationCodeNotifier.value = data.invitationCode ?? "";
      //   }
      // });
    } else {
      // locator<AccountService>().getProfileInfo().then((value) {
      //   final data = value.data;

      //   if (data != null) {
      //     invitationCodeNotifier.value = data.invitationCode ?? "";
      //   }
      // });
    }
  }

  @override
  onDispose() {
    invitationCodeNotifier.dispose();
  }
}
