import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:legalz_hub_app/models/https/countries_model.dart';
import 'package:legalz_hub_app/screens/tutorials/tutorials_screen.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/shared_widget/shimmers/shimmer_list.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/routes.dart';

class ListOfCountriesWidget extends StatelessWidget {
  final ValueNotifier<List<Country>> countriesListNotifier;
  const ListOfCountriesWidget({super.key, required this.countriesListNotifier});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<List<Country>>(
          valueListenable: countriesListNotifier,
          builder: (context, data, child) {
            return data.isEmpty
                ? const ShimmerListView(count: 10)
                : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return countryTile(context, data[index]);
                    });
          }),
    );
  }

  Widget countryTile(BuildContext context, Country item) {
    final navigator = Navigator.of(context, rootNavigator: true);
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
      child: InkWell(
        onTap: () async {
          var box = await Hive.openBox(DatabaseBoxConstant.userInfo);

          await box.put(
              DatabaseFieldConstant.selectedCountryId, item.id.toString());
          await box.put(
              DatabaseFieldConstant.selectedCountryFlag, item.flagImage);
          await box.put(DatabaseFieldConstant.selectedCountryName, item.name);
          await box.put(
              DatabaseFieldConstant.selectedCountryDialCode, item.dialCode);
          await box.put(
              DatabaseFieldConstant.selectedCountryCurrency, item.currency);
          await box.put(DatabaseFieldConstant.selectedCountryMinLenght,
              item.minLength.toString());
          await box.put(DatabaseFieldConstant.selectedCountryMaxLenght,
              item.maxLength.toString());

          navigator.pushNamedAndRemoveUntil(
            RoutesConstants.tutorialsScreen,
            (Route<dynamic> route) => false,
            arguments: {"openFrom": TutorialOpenFrom.firstInstall},
          );
        },
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width - 16,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              children: [
                SizedBox(
                    width: 40,
                    height: 40,
                    child: FadeInImage(
                        placeholder: const AssetImage(
                            "assets/images/flagPlaceHolderImg.png"),
                        image: NetworkImage(item.flagImage!, scale: 1))),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomText(
                    title: item.name!,
                    fontSize: 16,
                    textColor: const Color(0xff034061),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
