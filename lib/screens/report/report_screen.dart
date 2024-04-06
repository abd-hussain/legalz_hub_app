import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/screens/report/report_bloc.dart';
import 'package:legalz_hub_app/screens/report/widget/attachments.dart';
import 'package:legalz_hub_app/screens/report/widget/footer.dart';
import 'package:legalz_hub_app/shared_widget/custom_appbar.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:legalz_hub_app/utils/enums/loading_status.dart';
import 'package:legalz_hub_app/utils/enums/report_type.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final bloc = ReportBloc();

  @override
  void didChangeDependencies() {
    bloc.handleReadingArguments(
        arguments: ModalRoute.of(context)!.settings.arguments);

    bloc.textController.addListener(() {
      bloc.validationFields();
    });
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
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: customAppBar(
            title: bloc.pageType == ReportPageType.issue
                ? AppLocalizations.of(context)!.reportanproblem
                : AppLocalizations.of(context)!.reportansuggestion),
        body: ValueListenableBuilder<LoadingStatus>(
            valueListenable: bloc.loadingStatus,
            builder: (context, loadingsnapshot, child) {
              if (loadingsnapshot != LoadingStatus.inprogress) {
                return SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: bloc.textController,
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)!
                                    .feedbackmessage,
                                hintMaxLines: 2,
                                hintStyle: const TextStyle(fontSize: 15),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              maxLines: 20,
                              maxLength: 500,
                            ),
                          ),
                        ),
                      )),
                      ReportAttatchment(
                        attach1: (file) => bloc.attach1 = file,
                        attach2: (file) => bloc.attach2 = file,
                        attach3: (file) => bloc.attach3 = file,
                      ),
                      ValueListenableBuilder<bool>(
                          valueListenable: bloc.enableSubmitBtn,
                          builder: (context, snapshot, child) {
                            return CustomButton(
                              enableButton: snapshot,
                              onTap: () {
                                bloc.loadingStatus.value =
                                    LoadingStatus.inprogress;

                                final navigator = Navigator.of(context);
                                bloc.callRequest(context).then((value) async {
                                  bloc.loadingStatus.value =
                                      LoadingStatus.finish;
                                  navigator.pop();
                                });
                              },
                            );
                          }),
                      const ReportFooterView(),
                      const SizedBox(height: 50),
                    ],
                  ),
                );
              } else {
                return const SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
