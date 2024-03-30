import 'package:flutter/material.dart';
import 'package:legalz_hub_app/screens/initial/initial_bloc.dart';
import 'package:legalz_hub_app/screens/initial/widgets/change_language_widget.dart';
import 'package:legalz_hub_app/screens/initial/widgets/list_of_countries_widget.dart';
import 'package:legalz_hub_app/screens/initial/widgets/title_table_widget.dart';

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
            ValueListenableBuilder<int>(
                valueListenable: _bloc.selectedLanguageNotifier,
                builder: (context, snapshot, child) {
                  return ChangeLanguageWidget(
                    selectionIndex: snapshot,
                    segmentChange: (index) async =>
                        await _bloc.setLanguageInStorage(context, index),
                  );
                }),
            const TitleTableWidget(),
            ListOfCountriesWidget(
                countriesListNotifier: _bloc.countriesListNotifier),
          ],
        ),
      ),
    );
  }
}
