import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:legalz_hub_app/models/https/categories_model.dart';
import 'package:legalz_hub_app/models/https/home_posts_response.dart';
import 'package:legalz_hub_app/screens/tabs/home_tab/widgets/bottom_sheets/edit_post_bottomsheet.dart';
import 'package:legalz_hub_app/screens/tabs/home_tab/widgets/posts/post_view_bottom_controllers_view.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/shared_widget/loading_view.dart';
import 'package:legalz_hub_app/utils/constants/constant.dart';
import 'package:legalz_hub_app/utils/constants/database_constant.dart';
import 'package:legalz_hub_app/utils/day_time.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';

class PostsListView extends StatelessWidget {
  const PostsListView(
      {super.key,
      required this.box,
      required this.postsList,
      required this.categories,
      required this.currentUserType,
      required this.commentsAction,
      required this.editPostAction,
      required this.deleteAction,
      required this.reportAction});
  final List<PostResponseData>? postsList;
  final UserType currentUserType;
  final Box<dynamic> box;
  final List<Category> categories;
  final Function(int id) commentsAction;
  final Function(
      {required int postId,
      required int catId,
      required String content,
      File? postImg}) editPostAction;
  final Function(int id) deleteAction;
  final Function(int id) reportAction;

  @override
  Widget build(BuildContext context) {
    return postsList != null
        ? postsList!.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: postsList!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: const Color(0xff034061),
                                      radius: 20,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: postsList![index].profileImg !=
                                                ""
                                            ? FadeInImage(
                                                placeholder: const AssetImage(
                                                    "assets/images/avatar.jpeg"),
                                                image: NetworkImage(
                                                  AppConstant
                                                          .imagesBaseURLForCustomer +
                                                      postsList![index]
                                                          .profileImg!,
                                                ))
                                            : Image.asset(
                                                'assets/images/avatar.jpeg',
                                                width: 110,
                                                height: 110,
                                                fit: BoxFit.fill,
                                              ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 8,
                                      bottom: 0,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 10,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child:
                                              postsList![index].flagImage != ""
                                                  ? FadeInImage(
                                                      placeholder: const AssetImage(
                                                          "assets/images/avatar.jpeg"),
                                                      image: NetworkImage(
                                                        AppConstant
                                                                .imagesBaseURLForCountries +
                                                            postsList![index]
                                                                .flagImage!,
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
                                    )
                                  ],
                                ),
                                const SizedBox(width: 4),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      title:
                                          "${postsList![index].firstName} ${postsList![index].lastName}",
                                      textColor: const Color(0xff444444),
                                      fontSize: 12,
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const SizedBox(height: 8),
                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: CustomText(
                                        title: DayTime().dateFormatterWithTime(
                                            postsList![index].createdAt!),
                                        textColor: const Color(0xff444444),
                                        fontSize: 10,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(child: Container()),
                                if (currentUserType == UserType.attorney)
                                  IconButton(
                                    onPressed: () =>
                                        reportAction(postsList![index].id!),
                                    icon: Icon(
                                      Icons.report_gmailerrorred_rounded,
                                      size: 20,
                                      color:
                                          currentUserType == UserType.attorney
                                              ? const Color(0xff292929)
                                              : const Color(0xff034061),
                                    ),
                                  )
                                else
                                  postsList![index].customersOwnerId ==
                                          box.get(DatabaseFieldConstant.userid)
                                      ? Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                EditPostBottomSheetsUtil()
                                                    .bottomSheet(
                                                  context: context,
                                                  initialCatId:
                                                      postsList![index]
                                                          .categoryId!,
                                                  initialContent:
                                                      postsList![index]
                                                          .content!,
                                                  initialPostImg:
                                                      postsList![index].postImg,
                                                  categories: categories,
                                                  editPostCallback: (
                                                      {required catId,
                                                      required content,
                                                      postImg}) {
                                                    editPostAction(
                                                        postId:
                                                            postsList![index]
                                                                .id!,
                                                        catId: catId,
                                                        content: content,
                                                        postImg: postImg);
                                                  },
                                                );
                                              },
                                              icon: Icon(
                                                Ionicons.create_outline,
                                                size: 20,
                                                color: currentUserType ==
                                                        UserType.attorney
                                                    ? const Color(0xff292929)
                                                    : const Color(0xff034061),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () => deleteAction(
                                                  postsList![index].id!),
                                              icon: Icon(
                                                Icons.close,
                                                size: 20,
                                                color: currentUserType ==
                                                        UserType.attorney
                                                    ? const Color(0xff292929)
                                                    : const Color(0xff034061),
                                              ),
                                            ),
                                          ],
                                        )
                                      : IconButton(
                                          onPressed: () => reportAction(
                                              postsList![index].id!),
                                          icon: Icon(
                                            Icons.report_gmailerrorred_rounded,
                                            size: 20,
                                            color: currentUserType ==
                                                    UserType.attorney
                                                ? const Color(0xff292929)
                                                : const Color(0xff034061),
                                          ),
                                        )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: CustomText(
                              title: postsList![index].content!,
                              textColor: const Color(0xff444444),
                              fontSize: 12,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (postsList![index].postImg != null)
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Center(
                                  child: FadeInImage(
                                placeholder: const AssetImage(
                                    "assets/images/avatar.jpeg"),
                                image: NetworkImage(
                                    AppConstant.imagesIDBaseURLForPosts +
                                        postsList![index].postImg!),
                                fit: BoxFit.fill,
                              )),
                            )
                          else
                            Container(),
                          PostViewBottomControllersView(
                            currentUserType: currentUserType,
                            numberComment: postsList![index].commentCount!,
                            commentAction: () =>
                                commentsAction(postsList![index].id!),
                          ),
                          const SizedBox(height: 8)
                        ],
                      ),
                    ),
                  );
                },
              )
            : SizedBox(
                height: 200,
                child: Center(
                  child: CustomText(
                    title: AppLocalizations.of(context)!.noitem,
                    textColor: const Color(0xff444444),
                    fontSize: 12,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
        : const LoadingView();
  }
}
