import 'package:flutter/material.dart';
import 'package:legalz_hub_app/screens/initial/initial_bloc.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/screens/initial/widgets/change_language_widget.dart';
import 'package:legalz_hub_app/screens/initial/widgets/list_of_countries_widget.dart';
import 'package:legalz_hub_app/screens/initial/widgets/title_table_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final _bloc = SetupBloc();

  @override
  void didChangeDependencies() {
    _bloc.getSystemLanguage(context).whenComplete(() {
      _bloc.listOfCountries();
    });
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
      backgroundColor: const Color(0xffF5F6F7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                "assets/images/logoz/logo-blue.png",
                height: 100,
                width: 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: CustomText(
                title: AppLocalizations.of(context)!.appshortdesc,
                fontSize: 20,
                textColor: const Color(0xff034061),
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
                maxLins: 3,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Container(height: 1, color: const Color(0xff034061)),
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<int>(
                valueListenable: _bloc.selectedLanguageNotifier,
                builder: (context, snapshot, child) {
                  return ChangeLanguageWidget(
                    selectionIndex: snapshot,
                    segmentChange: (index) async => await _bloc.setLanguageInStorage(context, index),
                  );
                }),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Container(height: 1, color: const Color(0xff034061)),
            ),
            const SizedBox(height: 20),
            const TitleTableWidget(),
            ListOfCountriesWidget(countriesListNotifier: _bloc.countriesListNotifier),
          ],
        ),
      ),
    );
  }
}
