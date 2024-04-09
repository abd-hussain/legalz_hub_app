import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:legalz_hub_app/models/https/attorney_model.dart';
import 'package:legalz_hub_app/models/https/categories_model.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/shared_widget/shimmers/shimmer_cards_list.dart';
import 'package:legalz_hub_app/utils/constants/constant.dart';
import 'package:legalz_hub_app/utils/currency.dart';
import 'package:legalz_hub_app/utils/routes.dart';

class CategoryMainView extends StatefulWidget {
  final Category selectedCategory;
  final List<AttorneyModelData>? attorneyListNotifier;

  const CategoryMainView(
      {required this.selectedCategory,
      required this.attorneyListNotifier,
      super.key});

  @override
  State<CategoryMainView> createState() => _CategoryMainViewState();
}

class _CategoryMainViewState extends State<CategoryMainView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width - 126,
        child: Column(
          children: [
            headerFilter(context),
            Expanded(
              child: widget.attorneyListNotifier == null
                  ? const ShimmerCardListView(count: 5)
                  : widget.attorneyListNotifier!.isEmpty
                      ? noMentorToShow(context)
                      : ListView.builder(
                          itemCount: widget.attorneyListNotifier!.length,
                          itemBuilder: (context, index) {
                            return _item(context, index,
                                widget.attorneyListNotifier!.length);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerFilter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CustomText(
                title: "${AppLocalizations.of(context)!.sort} : ",
                fontSize: 10,
                textColor: const Color(0xff444444),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    filterIcon(
                        text: AppLocalizations.of(context)!.price,
                        icon: Ionicons.logo_bitcoin,
                        onPress: () {
                          widget.attorneyListNotifier!.sort(
                              (a, b) => a.hourRate!.compareTo(b.hourRate!));
                          setState(() {});
                        }),
                    const SizedBox(width: 3),
                    filterIcon(
                        text: AppLocalizations.of(context)!.rate,
                        icon: Ionicons.star_half_outline,
                        onPress: () {
                          widget.attorneyListNotifier!
                              .sort((a, b) => b.rate!.compareTo(a.rate!));
                          setState(() {});
                        }),
                    const SizedBox(width: 3),
                    filterIcon(
                        text: AppLocalizations.of(context)!.countryprofile,
                        icon: Ionicons.navigate_circle_outline,
                        onPress: () {
                          widget.attorneyListNotifier!.sort((a, b) =>
                              a.countryName!.compareTo(b.countryName!));
                          setState(() {});
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget filterIcon(
      {required String text,
      required IoniconsData icon,
      required Function onPress}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onPress(),
        child: Container(
          height: 55,
          width: 55,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 10,
                color: const Color(0xff034061),
              ),
              const SizedBox(height: 3),
              CustomText(
                title: text,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                textColor: const Color(0xff444444),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget noMentorToShow(BuildContext context) {
    return Center(
      child: CustomText(
        title: AppLocalizations.of(context)!.noitem,
        fontSize: 14,
        textColor: const Color(0xff444444),
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _item(BuildContext context, int index, int listLenght) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          _card(context, widget.attorneyListNotifier![index]),
          listLenght - 1 == index
              ? const SizedBox(
                  height: 16,
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget _card(BuildContext context, AttorneyModelData data) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).pushNamed(
            RoutesConstants.attorneyProfileScreen,
            arguments: {"id": data.id ?? 0});
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: 75,
                    height: 100,
                    child: Center(
                      child: data.profileImg !=
                              AppConstant.imagesBaseURLForAttorney
                          ? FadeInImage(
                              placeholder:
                                  const AssetImage("assets/images/avatar.jpeg"),
                              image: NetworkImage(data.profileImg!),
                              fit: BoxFit.fill,
                            )
                          : Image.asset(
                              'assets/images/avatar.jpeg',
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: data.suffixeName!,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        textColor: const Color(0xff444444),
                      ),
                      CustomText(
                        title: data.firstName!,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textColor: const Color(0xff444444),
                      ),
                      CustomText(
                        title: data.lastName!,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        textColor: const Color(0xff444444),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          ClipOval(
                            child: FadeInImage(
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                                placeholder: const AssetImage(
                                    "assets/images/flagPlaceHolderImg.png"),
                                image:
                                    NetworkImage(data.countryFlag!, scale: 1)),
                          ),
                          const SizedBox(width: 8),
                          CustomText(
                            title: data.countryName!,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            textColor: const Color(0xff444444),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(
                            Ionicons.language,
                            size: 12,
                          ),
                          const CustomText(
                            title: " : ",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            textColor: Color(0xff444444),
                          ),
                          const SizedBox(width: 2),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.5,
                            height: 20,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.languages!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Container(
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Center(
                                          child: CustomText(
                                            title: data.languages![
                                                index], //== "English" ? "E" : "ع",
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            textColor: const Color(0xff444444),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                      const SizedBox(width: 6),
                      Row(
                        children: [
                          const Icon(
                            Ionicons.star_half_outline,
                            size: 12,
                          ),
                          const CustomText(
                            title: " : ",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            textColor: Color(0xff444444),
                          ),
                          RatingBarIndicator(
                            rating: data.rate!,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 14,
                          ),
                          const SizedBox(width: 2),
                          CustomText(
                            title: "${data.numberOfReviewers} ",
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            textColor: const Color(0xff444444),
                          ),
                          CustomText(
                            title: AppLocalizations.of(context)!.vote,
                            fontSize: 12,
                            textColor: const Color(0xff444444),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              title: Currency().calculateHourRate(
                                  data.hourRate!,
                                  Timing.halfHour,
                                  data.currency!,
                                  false),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              textColor: const Color(0xff034061),
                            ),
                            CustomText(
                              title: "30 ${AppLocalizations.of(context)!.min}",
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              textColor: const Color(0xff034061),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
