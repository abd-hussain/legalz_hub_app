import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:legalz_hub_app/models/https/attorney_details_model.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/utils/constants/constant.dart';
import 'package:legalz_hub_app/utils/day_time.dart';

class ReviewBodyView extends StatelessWidget {
  const ReviewBodyView({required this.reviews, super.key});
  final List<Reviews> reviews;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: reviews.isEmpty ? 20 : 400,
        child: ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: const Color(0xff034061),
                              radius: 20,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: reviews[index].customerProfileImg != ""
                                    ? SizedBox(
                                        width: 110,
                                        height: 110,
                                        child: FadeInImage(
                                          placeholder: const AssetImage(
                                              "assets/images/avatar.jpeg"),
                                          image: NetworkImage(
                                              AppConstant
                                                      .imagesBaseURLForCustomer +
                                                  reviews[index]
                                                      .customerProfileImg!,
                                              scale: 2),
                                        ),
                                      )
                                    : Image.asset(
                                        'assets/images/avatar.jpeg',
                                        width: 110,
                                        height: 110,
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    title:
                                        "${reviews[index].customerFirstName!} ${reviews[index].customerLastName!}",
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    textColor: const Color(0xff554d56),
                                  ),
                                  CustomText(
                                    title: DayTime().dateFormatter(
                                        reviews[index].createdAt!),
                                    fontSize: 10,
                                    textColor: const Color(0xff554d56),
                                  ),
                                  const SizedBox(height: 4),
                                  RatingBarIndicator(
                                    rating: reviews[index].stars!,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemSize: 10,
                                  ),
                                  const SizedBox(height: 4),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    child: CustomText(
                                      title: reviews[index].comments!,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      maxLins: 10,
                                      textColor: const Color(0xff554d56),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (reviews[index].attorneyResponse! != "")
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 100,
                            child: Column(
                              children: [
                                CustomText(
                                  title:
                                      "-- ${AppLocalizations.of(context)!.mentorrespond} --",
                                  fontSize: 14,
                                  textColor: const Color(0xff554d56),
                                ),
                                CustomText(
                                  title: reviews[index].attorneyResponse!,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  maxLins: 10,
                                  textColor: const Color(0xff554d56),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    else
                      const SizedBox(),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
