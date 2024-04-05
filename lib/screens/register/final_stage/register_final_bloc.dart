import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/models/https/attoreny_register_model.dart';
import 'package:legalz_hub_app/models/working_hours.dart';
import 'package:legalz_hub_app/services/attorney/attorney_register_service.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/day_time.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/gender_format.dart';
import 'package:legalz_hub_app/utils/mixins.dart';
import 'package:legalz_hub_app/utils/version.dart';

class RegisterFinalBloc extends Bloc<AttorneyRegisterService> {
  ValueNotifier<LoadingStatus> loadingStatus =
      ValueNotifier<LoadingStatus>(LoadingStatus.idle);
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  Future<dynamic> handleCreatingTheProfile(BuildContext context) async {
    String? version = await Version().getApplicationVersion();
    int gender = 0;
    if (context.mounted) {
      gender = GenderFormat().convertStringToIndex(
          context, box.get(TempFieldToRegistrtAttorneyConstant.gender));
    }

    List<WorkingHourUTCModel> workingHoursUTC = DayTime().prepareTimingToUTC(
      workingHoursSaturday:
          box.get(TempFieldToRegistrtAttorneyConstant.saturdayWH) ?? [],
      workingHoursSunday:
          box.get(TempFieldToRegistrtAttorneyConstant.sundayWH) ?? [],
      workingHoursMonday:
          box.get(TempFieldToRegistrtAttorneyConstant.mondayWH) ?? [],
      workingHoursTuesday:
          box.get(TempFieldToRegistrtAttorneyConstant.tuesdayWH) ?? [],
      workingHoursWednesday:
          box.get(TempFieldToRegistrtAttorneyConstant.wednesdayWH) ?? [],
      workingHoursThursday:
          box.get(TempFieldToRegistrtAttorneyConstant.thursdayWH) ?? [],
      workingHoursFriday:
          box.get(TempFieldToRegistrtAttorneyConstant.fridayWH) ?? [],
    );

    final model = AttorneyRegister(
      appVersion: version,
      gender: gender,
      suffixeName: box.get(TempFieldToRegistrtAttorneyConstant.suffix) ?? "",
      firstName: box.get(TempFieldToRegistrtAttorneyConstant.firstName) ?? "",
      lastName: box.get(TempFieldToRegistrtAttorneyConstant.lastName) ?? "",
      dateOfBirth:
          box.get(TempFieldToRegistrtAttorneyConstant.dateOfBirth) ?? "",
      hourRate: box.get(TempFieldToRegistrtAttorneyConstant.ratePerHour) ?? "",
      iban: box.get(TempFieldToRegistrtAttorneyConstant.iban) ?? "",
      password: box.get(TempFieldToRegistrtAttorneyConstant.password) ?? "",
      bio: box.get(TempFieldToRegistrtAttorneyConstant.bio) ?? "",
      categoryId: box.get(TempFieldToRegistrtAttorneyConstant.category) ?? "",
      countryId: box.get(TempFieldToRegistrtAttorneyConstant.country) ?? "",
      email: box.get(TempFieldToRegistrtAttorneyConstant.email) ?? "",
      mobileNumber:
          box.get(TempFieldToRegistrtAttorneyConstant.phoneNumber) ?? "",
      referalCode:
          box.get(TempFieldToRegistrtAttorneyConstant.referalCode) ?? "",
      speakingLanguage:
          box.get(TempFieldToRegistrtAttorneyConstant.speakingLanguages) ?? [],
      profileImg: box.get(TempFieldToRegistrtAttorneyConstant.profileImage),
      cv: box.get(TempFieldToRegistrtAttorneyConstant.cv),
      idImg: box.get(TempFieldToRegistrtAttorneyConstant.idImage),
      cert1: box.get(TempFieldToRegistrtAttorneyConstant.certificates1),
      cert2: box.get(TempFieldToRegistrtAttorneyConstant.certificates2),
      cert3: box.get(TempFieldToRegistrtAttorneyConstant.certificates3),
      pushToken: box.get(DatabaseFieldConstant.pushNotificationToken),
      workingHoursSaturday: workingHoursUTC
          .where((element) => element.dayName == DayNameEnum.saturday)
          .first
          .list,
      workingHoursSunday: workingHoursUTC
          .where((element) => element.dayName == DayNameEnum.sunday)
          .first
          .list,
      workingHoursMonday: workingHoursUTC
          .where((element) => element.dayName == DayNameEnum.monday)
          .first
          .list,
      workingHoursTuesday: workingHoursUTC
          .where((element) => element.dayName == DayNameEnum.tuesday)
          .first
          .list,
      workingHoursWednesday: workingHoursUTC
          .where((element) => element.dayName == DayNameEnum.wednesday)
          .first
          .list,
      workingHoursThursday: workingHoursUTC
          .where((element) => element.dayName == DayNameEnum.thursday)
          .first
          .list,
      workingHoursFriday: workingHoursUTC
          .where((element) => element.dayName == DayNameEnum.friday)
          .first
          .list,
      experienceSince:
          box.get(TempFieldToRegistrtAttorneyConstant.experianceSince) ?? "",
    );

    return await service.callRegister(data: model);
  }

  Future<void> clearRegistrationData() async {
    await box.deleteAll([
      TempFieldToRegistrtAttorneyConstant.gender,
      TempFieldToRegistrtAttorneyConstant.suffix,
      TempFieldToRegistrtAttorneyConstant.firstName,
      TempFieldToRegistrtAttorneyConstant.lastName,
      TempFieldToRegistrtAttorneyConstant.dateOfBirth,
      TempFieldToRegistrtAttorneyConstant.ratePerHour,
      TempFieldToRegistrtAttorneyConstant.iban,
      TempFieldToRegistrtAttorneyConstant.password,
      TempFieldToRegistrtAttorneyConstant.bio,
      TempFieldToRegistrtAttorneyConstant.category,
      TempFieldToRegistrtAttorneyConstant.country,
      TempFieldToRegistrtAttorneyConstant.email,
      TempFieldToRegistrtAttorneyConstant.phoneNumber,
      TempFieldToRegistrtAttorneyConstant.referalCode,
      TempFieldToRegistrtAttorneyConstant.speakingLanguages,
      TempFieldToRegistrtAttorneyConstant.profileImage,
      TempFieldToRegistrtAttorneyConstant.cv,
      TempFieldToRegistrtAttorneyConstant.idImage,
      TempFieldToRegistrtAttorneyConstant.certificates1,
      TempFieldToRegistrtAttorneyConstant.certificates2,
      TempFieldToRegistrtAttorneyConstant.certificates3,
      TempFieldToRegistrtAttorneyConstant.saturdayWH,
      TempFieldToRegistrtAttorneyConstant.sundayWH,
      TempFieldToRegistrtAttorneyConstant.mondayWH,
      TempFieldToRegistrtAttorneyConstant.tuesdayWH,
      TempFieldToRegistrtAttorneyConstant.wednesdayWH,
      TempFieldToRegistrtAttorneyConstant.thursdayWH,
      TempFieldToRegistrtAttorneyConstant.fridayWH,
      TempFieldToRegistrtAttorneyConstant.experianceSince,
      DatabaseFieldConstant.attorneyRegistrationStep
    ]);
  }

  @override
  onDispose() {
    loadingStatus.dispose();
  }
}
