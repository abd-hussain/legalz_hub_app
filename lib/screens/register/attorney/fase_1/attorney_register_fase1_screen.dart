import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/models/https/countries_model.dart';
import 'package:legalz_hub_app/screens/register/attorney/fase_1/attorney_register_fase1_bloc.dart';
import 'package:legalz_hub_app/shared_widget/mobile_header.dart';
import 'package:legalz_hub_app/shared_widget/mobile_number_widget.dart';
import 'package:legalz_hub_app/screens/register/widgets/footer_view.dart';
import 'package:legalz_hub_app/shared_widget/country_field.dart';
import 'package:legalz_hub_app/shared_widget/custom_appbar.dart';
import 'package:legalz_hub_app/shared_widget/custom_attach_textfield.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/shared_widget/custom_textfield.dart';
import 'package:legalz_hub_app/shared_widget/date_of_birth/date_of_birth_view.dart';
import 'package:legalz_hub_app/shared_widget/gender_field.dart';
import 'package:legalz_hub_app/shared_widget/image_holder_field.dart';
import 'package:legalz_hub_app/shared_widget/loading_view.dart';
import 'package:legalz_hub_app/shared_widget/suffix_field.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/routes.dart';

class AttorneyRegister1Screen extends StatefulWidget {
  const AttorneyRegister1Screen({super.key});

  @override
  State<AttorneyRegister1Screen> createState() =>
      _AttorneyRegister1ScreenState();
}

class _AttorneyRegister1ScreenState extends State<AttorneyRegister1Screen> {
  final bloc = AttorneyRegister1Bloc();

  @override
  void didChangeDependencies() {
    bloc.getlistOfSuffix();
    bloc.getlistOfCountries();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "", userType: UserType.attorney),
      bottomNavigationBar: StreamBuilder<bool?>(
          initialData: false,
          stream: bloc.enableNextBtn.stream,
          builder: (context, snapshot) {
            return RegistrationFooterView(
              pageCount: 1,
              pageTitle: AppLocalizations.of(context)!.personaldetails,
              nextPageTitle: AppLocalizations.of(context)!.experiences,
              enableNextButton: snapshot.data!,
              nextPressed: () async {
                final navigator = Navigator.of(context);
                await bloc.box.put(TempFieldToRegistrtAttorneyConstant.suffix,
                    bloc.suffixNameController.text);
                await bloc.box.put(
                    TempFieldToRegistrtAttorneyConstant.firstName,
                    bloc.firstNameController.text);
                await bloc.box.put(TempFieldToRegistrtAttorneyConstant.lastName,
                    bloc.lastNameController.text);
                await bloc.box.put(TempFieldToRegistrtAttorneyConstant.country,
                    bloc.selectedCountry!.id.toString());
                await bloc.box.put(TempFieldToRegistrtAttorneyConstant.gender,
                    bloc.genderController.text);
                await bloc.box.put(
                    TempFieldToRegistrtAttorneyConstant.profileImage,
                    bloc.profileImage != null ? bloc.profileImage!.path : "");
                await bloc.box.put(TempFieldToRegistrtAttorneyConstant.idImage,
                    bloc.iDImage != null ? bloc.iDImage!.path : "");
                await bloc.box.put(
                    TempFieldToRegistrtAttorneyConstant.dateOfBirth,
                    bloc.selectedDate);
                await bloc.box.put(
                    TempFieldToRegistrtAttorneyConstant.phoneNumber,
                    bloc.countryCode + bloc.mobileController);

                await bloc.box.put(
                    TempFieldToRegistrtAttorneyConstant.referalCode,
                    bloc.validateReferalCode.value == true
                        ? bloc.referalCodeController.text
                        : "");
                await bloc.box
                    .put(DatabaseFieldConstant.attorneyRegistrationStep, "2");
                navigator.pushNamed(RoutesConstants.registerAttornyFaze2Screen);
              },
            );
          }),
      body: StreamBuilder<LoadingStatus>(
          initialData: LoadingStatus.inprogress,
          stream: bloc.loadingStatusController.stream,
          builder: (context, snapshot) {
            return snapshot.data == LoadingStatus.inprogress
                ? const LoadingView()
                : GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (bloc.referalCodeController.text.isEmpty) {
                        bloc.validateReferalCode.value = null;
                      } else {
                        bloc.validateReferal(bloc.referalCodeController.text);
                      }
                      bloc.validateFieldsForFaze1();
                    },
                    child: SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
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
                                      isFromNetwork: bloc.profileImageUrl != "",
                                      urlImage: bloc.profileImageUrl == ""
                                          ? null
                                          : bloc.profileImageUrl,
                                      onAddImage: (file) {
                                        bloc.profileImage = file;
                                        bloc.validateFieldsForFaze1();
                                      },
                                      onDeleteImage: () {
                                        bloc.profileImage = null;
                                        bloc.profileImageUrl = "";
                                        bloc.validateFieldsForFaze1();
                                        setState(() {});
                                      }),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        ValueListenableBuilder<Object>(
                                            valueListenable: bloc.listOfSuffix,
                                            builder:
                                                (context, snapshot, child) {
                                              return SuffixField(
                                                controller:
                                                    bloc.suffixNameController,
                                                listOfSuffix:
                                                    bloc.listOfSuffix.value,
                                                selectedSuffix: (p0) {
                                                  bloc.selectedSuffix = p0;
                                                  bloc.validateFieldsForFaze1();
                                                },
                                              );
                                            }),
                                        const SizedBox(height: 10),
                                        CustomTextField(
                                          controller: bloc.firstNameController,
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .firstnameprofile,
                                          keyboardType: TextInputType.name,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(45)
                                          ],
                                          onChange: (text) =>
                                              bloc.validateFieldsForFaze1(),
                                          onEditingComplete: () => FocusManager
                                              .instance.primaryFocus
                                              ?.unfocus(),
                                        ),
                                        const SizedBox(height: 10),
                                        CustomTextField(
                                          controller: bloc.lastNameController,
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .lastnameprofile,
                                          keyboardType: TextInputType.name,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(45)
                                          ],
                                          onChange: (text) =>
                                              bloc.validateFieldsForFaze1(),
                                          onEditingComplete: () => FocusManager
                                              .instance.primaryFocus
                                              ?.unfocus(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                                height: 1, color: const Color(0xffE8E8E8)),
                            const SizedBox(height: 16),
                            Padding(
                              padding: bloc.box.get(
                                          DatabaseFieldConstant.language) ==
                                      "ar"
                                  ? const EdgeInsets.only(right: 16)
                                  : const EdgeInsets.only(left: 16),
                              child: Row(
                                children: [
                                  CustomAttachTextField(
                                      isFromNetwork: bloc.iDImageUrl != "",
                                      urlImage: bloc.iDImageUrl == ""
                                          ? null
                                          : bloc.iDImageUrl,
                                      onAddImage: (file) {
                                        bloc.iDImage = file;
                                        bloc.validateFieldsForFaze1();
                                      },
                                      onDeleteImage: () {
                                        bloc.iDImage = null;
                                        bloc.iDImageUrl = "";
                                        bloc.validateFieldsForFaze1();
                                        setState(() {});
                                      }),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        ValueListenableBuilder<List<Country>>(
                                            valueListenable:
                                                bloc.listOfCountries,
                                            builder:
                                                (context, snapshot, child) {
                                              return CountryField(
                                                controller:
                                                    bloc.countryController,
                                                listOfCountries: snapshot,
                                                selectedCountry: (p0) {
                                                  bloc.selectedCountry = p0;
                                                  bloc.validateFieldsForFaze1();
                                                },
                                              );
                                            }),
                                        const SizedBox(height: 10),
                                        GenderField(
                                          controller: bloc.genderController,
                                          onChange: (p0) =>
                                              bloc.validateFieldsForFaze1(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                                height: 1, color: const Color(0xffE8E8E8)),
                            const SizedBox(height: 16),
                            const MobileHeader(),
                            ValueListenableBuilder<List<Country>>(
                                valueListenable: bloc.listOfCountries,
                                builder: (context, snapshot, child) {
                                  return MobileNumberField(
                                      initialCountry: bloc
                                          .returnSelectedCountryFromDatabase(),
                                      countryList: snapshot,
                                      selectedCountryCode: (selectedCode) {
                                        if (selectedCode != null) {
                                          bloc.country = selectedCode;
                                          bloc.countryCode =
                                              selectedCode.dialCode!;
                                        }
                                        bloc.validateFieldsForFaze1();
                                      },
                                      enteredPhoneNumber: (mobileNumber) {
                                        if (bloc.country!.maxLength ==
                                            mobileNumber.length) {
                                          bloc.mobileController = mobileNumber;
                                          bloc.validateMobileNumber(
                                              bloc.country!.dialCode! +
                                                  bloc.mobileController);
                                        }
                                      },
                                      validatePhoneNumber: (value) {
                                        bloc.validatePhoneNumber = value;
                                        bloc.validateFieldsForFaze1();
                                      });
                                }),
                            ValueListenableBuilder<bool>(
                                valueListenable: bloc.mobileNumberErrorMessage,
                                builder: (context, snapshot, child) {
                                  return CustomText(
                                    title: snapshot
                                        ? AppLocalizations.of(context)!
                                            .mobilenumberalreadyinuse
                                        : "",
                                    fontSize: 14,
                                    textColor: Colors.red,
                                  );
                                }),
                            const SizedBox(height: 16),
                            Container(
                                height: 1, color: const Color(0xffE8E8E8)),
                            const SizedBox(height: 16),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: CustomText(
                                title: AppLocalizations.of(context)!.dbprofile,
                                textAlign: TextAlign.start,
                                fontSize: 14,
                                textColor: const Color(0xff384048),
                              ),
                            ),
                            const SizedBox(height: 10),
                            DateOfBirthField(
                              language:
                                  bloc.box.get(DatabaseFieldConstant.language),
                              selectedDate: bloc.selectedDate,
                              dateSelected: (p0) {
                                bloc.selectedDate = p0;
                                bloc.validateFieldsForFaze1();
                              },
                            ),
                            const SizedBox(height: 16),
                            Container(
                                color: const Color(0xffE8E8E8), height: 1),
                            const SizedBox(height: 16),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                              child: CustomText(
                                title: AppLocalizations.of(context)!.optional,
                                textAlign: TextAlign.start,
                                fontSize: 14,
                                textColor: const Color(0xff384048),
                              ),
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: bloc.referalCodeController,
                              hintText: AppLocalizations.of(context)!
                                  .referalcodeprofile,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(6)
                              ],
                              onChange: (text) => bloc.validateFieldsForFaze1(),
                              onEditingComplete: () {
                                bloc.validateReferal(
                                    bloc.referalCodeController.text);
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                            ),
                            ValueListenableBuilder<bool?>(
                                valueListenable: bloc.validateReferalCode,
                                builder: (context, snapshot, child) {
                                  if (snapshot == null) {
                                    return Container();
                                  } else {
                                    return Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: CustomText(
                                            title: snapshot
                                                ? AppLocalizations.of(context)!
                                                    .codevalid
                                                : AppLocalizations.of(context)!
                                                    .codenotvalid,
                                            fontSize: 12,
                                            textColor: snapshot
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                }),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  );
          }),
    );
  }
}
