import 'package:flutter/material.dart';
import 'package:legalz_hub_app/models/https/home_posts_response.dart';
import 'package:legalz_hub_app/screens/tabs/home_tab/widgets/post_view_bottom_controllers_view.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/utils/constants/constant.dart';
import 'package:legalz_hub_app/utils/day_time.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';

class PostsView extends StatelessWidget {
  final List<PostResponseData>? postsList;
  final UserType currentUserType;
  const PostsView({super.key, required this.postsList, required this.currentUserType});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xff034061),
                            radius: 20,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: postsList![index].profileImg != ""
                                  ? FadeInImage(
                                      placeholder: const AssetImage("assets/images/avatar.jpeg"),
                                      image: NetworkImage(
                                        AppConstant.imagesBaseURLForCustomer + postsList![index].profileImg!,
                                        scale: 1,
                                      ))
                                  : Image.asset(
                                      'assets/images/avatar.jpeg',
                                      width: 110.0,
                                      height: 110.0,
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
                                borderRadius: BorderRadius.circular(20),
                                child: postsList![index].flagImage != ""
                                    ? FadeInImage(
                                        placeholder: const AssetImage("assets/images/avatar.jpeg"),
                                        image: NetworkImage(
                                            AppConstant.imagesBaseURLForCountries + postsList![index].flagImage!,
                                            scale: 1),
                                      )
                                    : Image.asset(
                                        'assets/images/avatar.jpeg',
                                        width: 110.0,
                                        height: 110.0,
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
                            title: "${postsList![index].firstName} ${postsList![index].lastName}",
                            textColor: const Color(0xff444444),
                            fontSize: 12,
                            textAlign: TextAlign.center,
                            maxLins: 1,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 8),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: CustomText(
                              title: DayTime().dateFormatterWithTime(postsList![index].createdAt!),
                              textColor: const Color(0xff444444),
                              fontSize: 10,
                              textAlign: TextAlign.center,
                              maxLins: 1,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    title: postsList![index].content!,
                    textColor: const Color(0xff444444),
                    fontSize: 12,
                    textAlign: TextAlign.center,
                    maxLins: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                PostViewBottomControllersView(
                  currentUserType: currentUserType,
                  numberOfUpRate: postsList![index].totalUp!,
                  upAction: () {},
                  downAction: () {},
                  commentAction: () {},
                  reportAction: () {},
                ),
                const SizedBox(height: 4)
              ],
            ),
          ),
        );
      },
    );
  }
}
