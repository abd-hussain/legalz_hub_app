import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

//TODO
class AddPostBottomSheetsUtil {
  Future bottomSheet(
      {required BuildContext context,
      required Function({required int catId, required String content, String? postImg}) addPost}) {
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
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 60,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ),
                    Expanded(
                      child: CustomText(
                        title: "ADD NEW Question",
                        textColor: const Color(0xff444444),
                        textAlign: TextAlign.center,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: CustomText(
                            title: AppLocalizations.of(context)!.submit,
                            fontSize: 12,
                            textColor: const Color(0xff444444),
                          )),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                //           TextButton(
                //             onPressed: () {
                //               deleteCallBack();
                //             },
                //             child: Row(
                //               children: [
                //                 const Icon(
                //                   Icons.hide_image,
                //                   color: Color(0xff4CB6EA),
                //                 ),
                //                 const SizedBox(width: 10),
                //                 CustomText(
                //                   title: AppLocalizations.of(context)!.pickimageremoveimage,
                //                   textColor: Colors.red,
                //                   fontSize: 16,
                //                 ),
                //               ],
                //             ),
                //           ),
                //           const SizedBox(height: 22),
                //         ],
                //       )
                //     : Column(
                //         mainAxisSize: MainAxisSize.min,
                //         children: [
                //           CustomText(
                //             title: title2,
                //             textColor: Colors.black,
                //             fontSize: 18,
                //           ),
                //           const SizedBox(height: 27.0),
                //           SizedBox(
                //             height: 100,
                //             child: Column(
                //               children: [
                //                 InkWell(
                //                   onTap: () {
                //                     Navigator.of(context).pop();
                //                     galleryCallBack();
                //                   },
                //                   child: SizedBox(
                //                     height: 50,
                //                     child: Row(
                //                       children: [
                //                         const SizedBox(
                //                           width: 40,
                //                           height: 40,
                //                           child: Icon(
                //                             Icons.image_outlined,
                //                             color: Color(0xff444444),
                //                           ),
                //                         ),
                //                         const SizedBox(width: 8),
                //                         Expanded(
                //                           child: CustomText(
                //                             title: AppLocalizations.of(context)!.pickimagefromstudio,
                //                             fontSize: 16,
                //                             textColor: const Color(0xff444444),
                //                           ),
                //                         ),
                //                         const Icon(
                //                           Icons.arrow_forward_ios,
                //                           size: 15,
                //                         )
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //                 InkWell(
                //                   onTap: () {
                //                     Navigator.of(context).pop();
                //                     cameraCallBack();
                //                   },
                //                   child: SizedBox(
                //                     height: 50,
                //                     child: Row(
                //                       children: [
                //                         const SizedBox(
                //                             width: 40,
                //                             height: 40,
                //                             child: Icon(
                //                               Icons.camera_alt_outlined,
                //                               color: Color(0xff444444),
                //                             )),
                //                         const SizedBox(width: 8),
                //                         Expanded(
                //                           child: CustomText(
                //                             title: AppLocalizations.of(context)!.pickimagefromcamera,
                //                             fontSize: 16,
                //                             textColor: const Color(0xff444444),
                //                           ),
                //                         ),
                //                         const Icon(
                //                           Icons.arrow_forward_ios,
                //                           size: 15,
                //                         )
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                const SizedBox(height: 22),
              ],
            ),
          );
        });
  }
}
