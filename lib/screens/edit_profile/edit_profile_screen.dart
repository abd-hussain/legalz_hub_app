import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/models/https/countries_model.dart';
import 'package:legalz_hub_app/models/https/suffix_model.dart';
import 'package:legalz_hub_app/models/working_hours.dart';
import 'package:legalz_hub_app/screens/edit_profile/edit_profile_bloc.dart';
import 'package:legalz_hub_app/shared_widget/bio_field.dart';
import 'package:legalz_hub_app/shared_widget/country_field.dart';
import 'package:legalz_hub_app/shared_widget/custom_appbar.dart';
import 'package:legalz_hub_app/shared_widget/custom_attach_textfield.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/shared_widget/custom_textfield.dart';
import 'package:legalz_hub_app/shared_widget/date_of_birth/date_of_birth_view.dart';
import 'package:legalz_hub_app/shared_widget/gender_field.dart';
import 'package:legalz_hub_app/shared_widget/image_holder_field.dart';
import 'package:legalz_hub_app/shared_widget/loading_view.dart';
import 'package:legalz_hub_app/shared_widget/speaking_language_field.dart';
import 'package:legalz_hub_app/shared_widget/suffix_field.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final bloc = EditProfileBloc();

  @override
  void didChangeDependencies() {
    bloc.userType = bloc.box.get(DatabaseFieldConstant.userType) == "customer"
        ? UserType.customer
        : UserType.attorney;
    bloc.getProfileInformations(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F4F5),
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(
        title: AppLocalizations.of(context)!.editprofileinformations,
        userType: bloc.userType,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.zero,
        child: ValueListenableBuilder<bool>(
            valueListenable: bloc.enableSaveButtonNotifier,
            builder: (context, snapshot, child) {
              return CustomButton(
                  enableButton: snapshot,
                  onTap: () {
                    bloc.updateProfileInfo(context).whenComplete(() {
                      Navigator.of(context).pop();
                    });
                  });
            }),
      ),
      body: SafeArea(
        child: ValueListenableBuilder<LoadingStatus>(
            valueListenable: bloc.loadingStatusNotifier,
            builder: (context, snapshot, child) {
              return snapshot == LoadingStatus.inprogress
                  ? const LoadingView()
                  : GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        bloc.validateFields();
                      },
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0.5,
                                  blurRadius: 5,
                                  offset: const Offset(0, 0.1),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Padding(
                                  padding: bloc.box.get(
                                              DatabaseFieldConstant.language) ==
                                          "ar"
                                      ? const EdgeInsets.only(right: 16)
                                      : const EdgeInsets.only(left: 16),
                                  child: Row(
                                    children: [
                                      ImageHolderField(
                                          isFromNetwork:
                                              bloc.profileImageUrl != "",
                                          urlImage: bloc.profileImageUrl == ""
                                              ? null
                                              : bloc.profileImageUrl,
                                          onAddImage: (file) {
                                            bloc.profileImage = file;
                                            bloc.validateFields();
                                          },
                                          onDeleteImage: () {
                                            bloc.profileImage = null;
                                            bloc.profileImageUrl = "";
                                            bloc.validateFields();
                                            setState(() {});
                                          }),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            if (bloc.userType ==
                                                UserType.attorney)
                                              ValueListenableBuilder<
                                                      List<SuffixData>>(
                                                  valueListenable:
                                                      bloc.listOfSuffix,
                                                  builder: (context, snapshot,
                                                      child) {
                                                    return SuffixField(
                                                      controller: bloc
                                                          .suffixNameController,
                                                      listOfSuffix: bloc
                                                          .listOfSuffix.value,
                                                      selectedSuffix: (p0) {
                                                        bloc.validateFields();
                                                      },
                                                    );
                                                  })
                                            else
                                              const SizedBox(),
                                            if (bloc.userType ==
                                                UserType.attorney)
                                              const SizedBox(height: 10)
                                            else
                                              const SizedBox(),
                                            CustomTextField(
                                              controller:
                                                  bloc.firstNameController,
                                              hintText:
                                                  AppLocalizations.of(context)!
                                                      .firstnameprofile,
                                              keyboardType: TextInputType.name,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    45),
                                              ],
                                              onChange: (text) {
                                                bloc.validateFields();
                                              },
                                            ),
                                            const SizedBox(height: 10),
                                            CustomTextField(
                                              controller:
                                                  bloc.lastNameController,
                                              hintText:
                                                  AppLocalizations.of(context)!
                                                      .lastnameprofile,
                                              keyboardType: TextInputType.name,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    45),
                                              ],
                                              onChange: (text) {
                                                bloc.validateFields();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                DateOfBirthField(
                                  language: bloc.box
                                      .get(DatabaseFieldConstant.language),
                                  selectedDate: bloc.selectedDate,
                                  dateSelected: (p0) {
                                    bloc.selectedDate = p0;
                                    bloc.validateFields();
                                  },
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  color: const Color(0xffE8E8E8),
                                  height: 1,
                                ),
                                if (bloc.userType == UserType.attorney)
                                  const SizedBox(height: 16)
                                else
                                  const SizedBox(),
                                if (bloc.userType == UserType.attorney)
                                  BioField(
                                    bioController: bloc.bioController,
                                    onChanged: (text) => bloc.validateFields(),
                                  )
                                else
                                  const SizedBox(),
                                if (bloc.userType == UserType.attorney)
                                  const SizedBox(height: 16)
                                else
                                  const SizedBox(),
                                if (bloc.userType == UserType.attorney)
                                  Container(
                                    color: const Color(0xffE8E8E8),
                                    height: 1,
                                  )
                                else
                                  const SizedBox(),
                                const SizedBox(height: 16),
                                Padding(
                                  padding: bloc.userType == UserType.attorney
                                      ? bloc.box.get(DatabaseFieldConstant
                                                  .language) ==
                                              "ar"
                                          ? const EdgeInsets.only(right: 16)
                                          : const EdgeInsets.only(left: 16)
                                      : EdgeInsets.zero,
                                  child: Row(
                                    children: [
                                      if (bloc.userType == UserType.attorney)
                                        CustomAttachTextField(
                                            isFromNetwork:
                                                bloc.iDImageUrl != "",
                                            urlImage: bloc.iDImageUrl == ""
                                                ? null
                                                : bloc.iDImageUrl,
                                            onAddImage: (file) {
                                              bloc.iDImage = file;
                                              bloc.validateFields();
                                            },
                                            onDeleteImage: () {
                                              bloc.iDImage = null;
                                              bloc.iDImageUrl = "";
                                              bloc.validateFields();
                                              setState(() {});
                                            })
                                      else
                                        const SizedBox(),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            ValueListenableBuilder<
                                                    List<Country>>(
                                                valueListenable: bloc
                                                    .listOfCountriesNotifier,
                                                builder:
                                                    (context, snapshot, child) {
                                                  return CountryField(
                                                    controller:
                                                        bloc.countryController,
                                                    listOfCountries: snapshot,
                                                    selectedCountry: (p0) {
                                                      bloc.selectedCountry = p0;
                                                      bloc.validateFields();
                                                    },
                                                  );
                                                }),
                                            const SizedBox(height: 10),
                                            GenderField(
                                              controller: bloc.genderController,
                                              onChange: (p0) =>
                                                  bloc.validateFields(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (bloc.userType == UserType.attorney)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 16, right: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          title: AppLocalizations.of(context)!
                                              .speakinglanguage,
                                          fontSize: 12,
                                          textColor: const Color(0xff444444),
                                        ),
                                        ValueListenableBuilder<List<CheckBox>>(
                                            valueListenable: bloc
                                                .listOfSpeakingLanguageNotifier,
                                            builder:
                                                (context, snapshot, child) {
                                              return SpeakingLanguageField(
                                                listOfLanguages: snapshot,
                                                selectedLanguage: (language) {
                                                  for (var item in language) {
                                                    print("item");
                                                    print(item.id);
                                                    print(item.isEnable);
                                                    print(item.value);
                                                  }

                                                  bloc.listOfSpeakingLanguageNotifier
                                                      .value = language;
                                                  bloc.validateFields();
                                                },
                                              );
                                            }),
                                      ],
                                    ),
                                  )
                                else
                                  const SizedBox(),
                                const SizedBox(height: 16),
                                Container(
                                  color: const Color(0xffE8E8E8),
                                  height: 1,
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  controller: bloc.emailController,
                                  hintText: AppLocalizations.of(context)!
                                      .emailaddress,
                                  keyboardType: TextInputType.emailAddress,
                                  readOnly: true,
                                  enabled: false,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(35),
                                  ],
                                  onChange: (text) => bloc.validateFields(),
                                ),
                                const SizedBox(height: 10),
                                CustomTextField(
                                  controller: bloc.mobileNumberController,
                                  readOnly: true,
                                  enabled: false,
                                  hintText: AppLocalizations.of(context)!
                                      .mobilenumber,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(35),
                                  ],
                                  onChange: (text) => bloc.validateFields(),
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  controller: bloc.referalCodeController,
                                  hintText: AppLocalizations.of(context)!
                                      .referalcodeprofile,
                                  readOnly: true,
                                  enabled: false,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(6)
                                  ],
                                  onChange: (text) => bloc.validateFields(),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
            }),
      ),
    );
  }
}
