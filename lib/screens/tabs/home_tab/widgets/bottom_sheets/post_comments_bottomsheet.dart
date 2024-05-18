import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:legalz_hub_app/models/https/comments_response.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/shared_widget/custom_textfield.dart';
import 'package:legalz_hub_app/utils/constants/constant.dart';
import 'package:legalz_hub_app/utils/day_time.dart';
import 'package:legalz_hub_app/utils/enums/user_type.dart';

class PostCommentsBottomSheetsUtil {
  TextEditingController commentTextField = TextEditingController();
  Future bottomSheet(
      {required BuildContext context,
      required List<CommentsResponseData>? comments,
      required int currentUserId,
      required UserType currentUserType,
      required Function(String) addCommentCallBack,
      required Function(int) deleteCommentCallBack}) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ),
                    Expanded(
                      child: CustomText(
                        title: AppLocalizations.of(context)!.commentsonposts,
                        textColor: const Color(0xff444444),
                        textAlign: TextAlign.center,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 100)
                  ],
                ),
                Expanded(
                  child: (comments != null && comments.isNotEmpty)
                      ? ListView.builder(
                          itemCount: comments.length,
                          itemBuilder: (ctx, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8),
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
                                                  child: comments[index].attorneyProfileImg != null ||
                                                          comments[index].customerProfileImg != null
                                                      ? FadeInImage(
                                                          placeholder: const AssetImage("assets/images/avatar.jpeg"),
                                                          image: comments[index].attorneyProfileImg != null
                                                              ? NetworkImage(
                                                                  AppConstant.imagesBaseURLForAttorney +
                                                                      comments[index].attorneyProfileImg!,
                                                                )
                                                              : NetworkImage(
                                                                  AppConstant.imagesBaseURLForCustomer +
                                                                      comments[index].customerProfileImg!,
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
                                                    borderRadius: BorderRadius.circular(20),
                                                    //   child: comments[index].flagImage != ""
                                                    //       ? FadeInImage(
                                                    //           placeholder: const AssetImage("assets/images/avatar.jpeg"),
                                                    //           image: NetworkImage(
                                                    //             AppConstant.imagesBaseURLForCountries +
                                                    //                 comments[index].flagImage!,
                                                    //           ),
                                                    //         )
                                                    //       : Image.asset(
                                                    //           'assets/images/avatar.jpeg',
                                                    //           width: 110,
                                                    //           height: 110,
                                                    //           fit: BoxFit.fill,
                                                    //         ),
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
                                                title: comments[index].attorneyFirstName != null
                                                    ? "${comments[index].attorneyFirstName} ${comments[index].attorneyLastName}"
                                                    : "${comments[index].customerFirstName} ${comments[index].customerLastName}",
                                                textColor: const Color(0xff444444),
                                                fontSize: 12,
                                                textAlign: TextAlign.center,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              const SizedBox(height: 8),
                                              Directionality(
                                                textDirection: TextDirection.ltr,
                                                child: CustomText(
                                                  title: DayTime().dateFormatterWithTime(comments[index].createdAt!),
                                                  textColor: const Color(0xff444444),
                                                  fontSize: 10,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(child: Container()),
                                          if ((currentUserType == UserType.attorney &&
                                                  comments[index].attorneyOwnerId == currentUserId) ||
                                              currentUserType == UserType.customer &&
                                                  comments[index].customersOwnerId == currentUserId)
                                            IconButton(
                                              onPressed: () => deleteCommentCallBack(comments[index].id!),
                                              icon: Icon(
                                                Icons.delete_sweep_outlined,
                                                size: 20,
                                                color: currentUserType == UserType.attorney
                                                    ? const Color(0xff292929)
                                                    : const Color(0xff034061),
                                              ),
                                            )
                                          else
                                            Container()
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: CustomText(
                                        title: comments[index].content ?? "",
                                        textColor: const Color(0xff444444),
                                        fontSize: 12,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
                      : Center(
                          child: CustomText(
                            title: AppLocalizations.of(context)!.noitem,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            textColor: const Color(0xff554d56),
                          ),
                        ),
                ),
                Container(
                  height: 70,
                  color: Colors.grey[300],
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: commentTextField,
                          hintText: AppLocalizations.of(context)!.addcommentfield,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            addCommentCallBack(commentTextField.text);
                            commentTextField.text = "";
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Ionicons.cloud_upload_outline,
                            color: currentUserType == UserType.attorney
                                ? const Color(0xff292929)
                                : const Color(0xff034061),
                          ))
                    ],
                  ),
                ),
                const SizedBox(height: 25)
              ],
            ),
          );
        });
  }
}
