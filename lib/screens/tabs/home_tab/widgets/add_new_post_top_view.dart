import 'dart:io';

import 'package:flutter/material.dart';
import 'package:legalz_hub_app/models/https/categories_model.dart';
import 'package:legalz_hub_app/screens/tabs/home_tab/widgets/add_post_bottomsheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class AddNewPostTopView extends StatelessWidget {
  final List<Category> listOfCategories;
  final Function({required int catId, required String content, File? postImg})
      addPost;
  const AddNewPostTopView(
      {super.key, required this.addPost, required this.listOfCategories});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AddPostBottomSheetsUtil().bottomSheet(
        context: context,
        categories: listOfCategories,
        addPost: ({required catId, required content, postImg}) {
          addPost(catId: catId, content: content, postImg: postImg);
        },
      ),
      child: Container(
        height: 80,
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          "assets/images/avatar.jpeg",
                          width: 30,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: const Color(0xffF5F6F7),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Center(
                            child: CustomText(
                              title: AppLocalizations.of(context)!
                                  .whatdoyouwanttoask,
                              fontSize: 11,
                              textColor:
                                  const Color.fromARGB(255, 148, 148, 148),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
                child: Row(
                  children: [
                    infoView(
                        text: AppLocalizations.of(context)!.ask,
                        icon: Icons.question_mark_rounded),
                    Container(
                      width: 0.5,
                      height: 15,
                      color: const Color(0xff444444),
                    ),
                    infoView(
                        text: AppLocalizations.of(context)!.answer,
                        icon: Icons.question_answer_outlined),
                    Container(
                      width: 0.5,
                      height: 15,
                      color: const Color(0xff444444),
                    ),
                    infoView(
                        text: AppLocalizations.of(context)!.share,
                        icon: Icons.share),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget infoView({required String text, required IconData icon}) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: const Color(0xff444444),
            size: 12,
          ),
          const SizedBox(width: 2),
          CustomText(
            title: text,
            fontSize: 10,
            textColor: const Color(0xff444444),
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
