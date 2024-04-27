import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/screens/edit_experience/edit_experience_bloc.dart';
import 'package:legalz_hub_app/screens/edit_experience/widgets/experiance_since.dart';
import 'package:legalz_hub_app/shared_widget/category_field.dart';
import 'package:legalz_hub_app/shared_widget/custom_appbar.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:legalz_hub_app/shared_widget/file_holder_field.dart';
import 'package:legalz_hub_app/shared_widget/loading_view.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';

class EditExperienceScreen extends StatefulWidget {
  const EditExperienceScreen({super.key});

  @override
  State<EditExperienceScreen> createState() => _EditExperienceScreenState();
}

class _EditExperienceScreenState extends State<EditExperienceScreen> {
  final bloc = EditExperienceBloc();
  @override
  void didChangeDependencies() {
    bloc.getProfileExperiance();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF3F4F5),
        resizeToAvoidBottomInset: false,
        appBar: customAppBar(
            title: AppLocalizations.of(context)!.editprofileeinexperiances,
            userType: UserType.attorney),
        body: SafeArea(
          child: SingleChildScrollView(
            child: ValueListenableBuilder<LoadingStatus>(
                valueListenable: bloc.loadingStatusNotifier,
                builder: (context, snapshot, child) {
                  return snapshot == LoadingStatus.inprogress
                      ? const LoadingView()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
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
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CategoryField(
                                        controller: bloc.categoryController,
                                        isEnable: false,
                                        padding: EdgeInsets.zero,
                                        listOfCategory: const [],
                                        selectedCategory: (p0) {},
                                      ),
                                      const SizedBox(height: 16),
                                      ExperianceSinceField(
                                        controller:
                                            bloc.experianceSinceController,
                                        padding: EdgeInsets.zero,
                                        onSelected: bloc.validateFields,
                                      ),
                                      const SizedBox(height: 16),
                                      FileHolderField(
                                        title: AppLocalizations.of(context)!.cv,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        currentFile: bloc.cvFileUrl.isNotEmpty
                                            ? File("")
                                            : null,
                                        onAddFile: (file) {
                                          bloc.cv = file;
                                          bloc.validateFields();
                                        },
                                        onRemoveFile: () {
                                          bloc.cv = null;

                                          bloc.validateFields();
                                        },
                                      ),
                                      const SizedBox(height: 8),
                                      Center(
                                        child: Column(
                                          children: [
                                            FileHolderField(
                                              title:
                                                  "${AppLocalizations.of(context)!.certificate} 1",
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              currentFile:
                                                  bloc.cert1FileUrl.isNotEmpty
                                                      ? File("")
                                                      : null,
                                              onAddFile: (file) {
                                                bloc.cv = file;
                                                bloc.validateFields();
                                              },
                                              onRemoveFile: () {
                                                bloc.cv = null;

                                                bloc.validateFields();
                                              },
                                            ),
                                            const SizedBox(height: 8),
                                            FileHolderField(
                                              title:
                                                  "${AppLocalizations.of(context)!.certificate} 2",
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              currentFile:
                                                  bloc.cert2FileUrl.isNotEmpty
                                                      ? File("")
                                                      : null,
                                              onAddFile: (file) {
                                                bloc.cv = file;
                                                bloc.validateFields();
                                              },
                                              onRemoveFile: () {
                                                bloc.cv = null;

                                                bloc.validateFields();
                                              },
                                            ),
                                            const SizedBox(height: 8),
                                            FileHolderField(
                                              title:
                                                  "${AppLocalizations.of(context)!.certificate} 3",
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              currentFile:
                                                  bloc.cert3FileUrl.isNotEmpty
                                                      ? File("")
                                                      : null,
                                              onAddFile: (file) {
                                                bloc.cv = file;
                                                bloc.validateFields();
                                              },
                                              onRemoveFile: () {
                                                bloc.cv = null;

                                                bloc.validateFields();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            ValueListenableBuilder<bool>(
                                valueListenable: bloc.enableSaveButton,
                                builder: (context, snapshot, child) {
                                  return CustomButton(
                                      enableButton: snapshot,
                                      onTap: () async {
                                        bloc.loadingStatusNotifier.value =
                                            LoadingStatus.inprogress;
                                        final navigation =
                                            Navigator.of(context);

                                        await bloc
                                            .updateProfileExperiance()
                                            .then((value) {
                                          bloc.loadingStatusNotifier.value =
                                              LoadingStatus.finish;

                                          navigation.pop();
                                        });
                                      });
                                }),
                          ],
                        );
                }),
          ),
        ),
      ),
    );
  }
}
