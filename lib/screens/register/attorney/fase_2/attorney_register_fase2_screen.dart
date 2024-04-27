import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/models/https/categories_model.dart';
import 'package:legalz_hub_app/models/working_hours.dart';
import 'package:legalz_hub_app/screens/register/attorney/fase_2/attorney_register_fase2_bloc.dart';
import 'package:legalz_hub_app/screens/register/widgets/footer_view.dart';
import 'package:legalz_hub_app/shared_widget/bio_field.dart';
import 'package:legalz_hub_app/shared_widget/category_field.dart';
import 'package:legalz_hub_app/shared_widget/certificate_view.dart';
import 'package:legalz_hub_app/shared_widget/custom_appbar.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/shared_widget/experiance_since.dart';
import 'package:legalz_hub_app/shared_widget/file_holder_field.dart';
import 'package:legalz_hub_app/shared_widget/loading_view.dart';
import 'package:legalz_hub_app/shared_widget/speaking_language_field.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';
import 'package:legalz_hub_app/utils/push_notifications/firebase_cloud_messaging_util.dart';
import 'package:legalz_hub_app/utils/routes.dart';

class AttorneyRegister2Screen extends StatefulWidget {
  const AttorneyRegister2Screen({super.key});

  @override
  State<AttorneyRegister2Screen> createState() =>
      _AttorneyRegister2ScreenState();
}

class _AttorneyRegister2ScreenState extends State<AttorneyRegister2Screen> {
  final bloc = AttorneyRegister2Bloc();

  @override
  void didChangeDependencies() {
    bloc.getlistOfCategories();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        FirebaseCloudMessagingUtil.initConfigure(context);
      });
    });
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
      bottomNavigationBar: ValueListenableBuilder<bool>(
          valueListenable: bloc.enableNextBtn,
          builder: (context, snapshot, child) {
            return RegistrationFooterView(
              pageCount: 2,
              pageTitle: AppLocalizations.of(context)!.experiences,
              nextPageTitle: AppLocalizations.of(context)!.workinghour,
              enableNextButton: snapshot,
              nextPressed: () async {
                final navigator = Navigator.of(context);
                await bloc.box.put(TempFieldToRegistrtAttorneyConstant.bio,
                    bloc.bioController.text);
                await bloc.box.put(TempFieldToRegistrtAttorneyConstant.category,
                    bloc.selectedCategory!.id.toString());
                await bloc.box.put(
                    TempFieldToRegistrtAttorneyConstant.experianceSince,
                    bloc.experianceSinceController.text);

                await bloc.box.put(TempFieldToRegistrtAttorneyConstant.cv,
                    bloc.cv != null ? bloc.cv!.path : "");

                await bloc.box.put(
                    TempFieldToRegistrtAttorneyConstant.certificates1,
                    bloc.cert1 != null ? bloc.cert1!.path : "");
                await bloc.box.put(
                    TempFieldToRegistrtAttorneyConstant.certificates2,
                    bloc.cert2 != null ? bloc.cert2!.path : "");
                await bloc.box.put(
                    TempFieldToRegistrtAttorneyConstant.certificates3,
                    bloc.cert3 != null ? bloc.cert3!.path : "");
                await bloc.box.put(
                    TempFieldToRegistrtAttorneyConstant.speakingLanguages,
                    bloc.filterListOfSelectedLanguage(
                        bloc.listOfSpeakingLanguageNotifier.value));

                await bloc.box
                    .put(DatabaseFieldConstant.attorneyRegistrationStep, "3");
                await navigator
                    .pushNamed(RoutesConstants.registerAttornyFaze3Screen);
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
                      bloc.validateFieldsForFaze2();
                    },
                    child: SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            ValueListenableBuilder<List<Category>>(
                                valueListenable: bloc.listOfCategories,
                                builder: (context, snapshot, child) {
                                  return CategoryField(
                                    controller: bloc.categoryController,
                                    listOfCategory: bloc.listOfCategories.value,
                                    selectedCategory: (p0) {
                                      bloc.selectedCategory = p0;
                                      bloc.validateFieldsForFaze2();
                                    },
                                  );
                                }),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 8, bottom: 8),
                              child: ExperianceSinceField(
                                controller: bloc.experianceSinceController,
                                padding: EdgeInsets.zero,
                                onSelected: bloc.validateFieldsForFaze2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: BioField(
                                bioController: bloc.bioController,
                                onChanged: (text) =>
                                    bloc.validateFieldsForFaze2(),
                              ),
                            ),
                            CustomText(
                              title: AppLocalizations.of(context)!
                                  .speakinglanguage,
                              fontSize: 12,
                              textColor: const Color(0xff444444),
                            ),
                            ValueListenableBuilder<List<CheckBox>>(
                                valueListenable:
                                    bloc.listOfSpeakingLanguageNotifier,
                                builder: (context, snapshot, child) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 8, bottom: 8),
                                    child: SpeakingLanguageField(
                                      listOfLanguages: snapshot,
                                      selectedLanguage: (language) {
                                        bloc.listOfSpeakingLanguageNotifier
                                            .value = language;
                                        bloc.validateFieldsForFaze2();
                                      },
                                    ),
                                  );
                                }),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Container(
                                  height: 0.5, color: const Color(0xff444444)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FileHolderField(
                                    title: AppLocalizations.of(context)!.cv,
                                    height: 150,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    currentFile: null,
                                    onAddFile: (file) {
                                      bloc.cv = file;
                                      bloc.validateFieldsForFaze2();
                                    },
                                    onRemoveFile: () {
                                      bloc.cv = null;
                                      bloc.validateFieldsForFaze2();
                                    },
                                  ),
                                  CertificateView(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height: 40,
                                    onChange: (cert1, cert2, cert3) {
                                      bloc.cert1 = cert1;
                                      bloc.cert2 = cert2;
                                      bloc.cert3 = cert3;

                                      bloc.validateFieldsForFaze2();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  );
          }),
    );
  }
}
