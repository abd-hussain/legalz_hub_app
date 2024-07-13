import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legalz_hub_app/models/add_post_model.dart';
import 'package:legalz_hub_app/models/https/categories_model.dart';
import 'package:legalz_hub_app/screens/tabs/home_tab/widgets/bottom_sheets/add_post_category_bottomsheet.dart';
import 'package:legalz_hub_app/shared_widget/bio_field.dart';
import 'package:legalz_hub_app/shared_widget/bottom_sheet_util.dart';
import 'package:legalz_hub_app/shared_widget/custom_button.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class AddPostBottomSheetsUtil {
  StreamController<AddPostModel> refreshPage =
      StreamController<AddPostModel>.broadcast();
  AddPostModel refreshObj =
      AddPostModel(categorySelected: null, attachment: null, content: null);
  TextEditingController textController = TextEditingController();
  File? image;

  Future bottomSheet(
      {required BuildContext context,
      required List<Category> categories,
      required Function(
              {required int catId, required String content, File? postImg})
          addPostCallback}) {
    final List<Category> listOfCategories =
        categories.where((s) => s.id != 0).toList();

    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: StreamBuilder<AddPostModel>(
                  stream: refreshPage.stream,
                  builder: (context, refreshPageSnapshot) {
                    return Column(
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
                                title: AppLocalizations.of(context)!
                                    .addnewquestion,
                                textColor: const Color(0xff444444),
                                textAlign: TextAlign.center,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: CustomButton(
                                  enableButton:
                                      validateFields(refreshPageSnapshot.data),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    addPostCallback(
                                      catId: refreshPageSnapshot
                                          .data!.categorySelected!.id!,
                                      content:
                                          refreshPageSnapshot.data!.content!,
                                      postImg:
                                          refreshPageSnapshot.data!.attachment,
                                    );
                                  }),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
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
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    title: AppLocalizations.of(context)!
                                        .tipsfornewquestiontitle,
                                    textColor: const Color(0xff444444),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    maxLins: 2,
                                  ),
                                  CustomText(
                                    title:
                                        "- ${AppLocalizations.of(context)!.tipsfornewquestion1}",
                                    textColor: const Color(0xff444444),
                                    fontSize: 11,
                                    maxLins: 2,
                                  ),
                                  CustomText(
                                    title:
                                        "- ${AppLocalizations.of(context)!.tipsfornewquestion2}",
                                    textColor: const Color(0xff444444),
                                    fontSize: 11,
                                    maxLins: 2,
                                  ),
                                  CustomText(
                                    title:
                                        "- ${AppLocalizations.of(context)!.tipsfornewquestion3}",
                                    textColor: const Color(0xff444444),
                                    maxLins: 2,
                                    fontSize: 11,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 16, bottom: 8),
                          child: InkWell(
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                    "assets/images/avatar.jpeg",
                                    width: 30,
                                  ),
                                ),
                                const CustomText(
                                  title: "*",
                                  textColor: Colors.red,
                                  fontSize: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    border: Border.all(
                                      color: const Color(0xFFEEEEEE),
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        CustomText(
                                          title: refreshObj.categorySelected ==
                                                  null
                                              ? AppLocalizations.of(context)!
                                                  .selectCategory
                                              : refreshObj
                                                  .categorySelected!.name!,
                                          textColor: const Color(0xff444444),
                                          fontSize: 11,
                                        ),
                                        const Icon(Icons.arrow_drop_down_sharp),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              AddPostCategoryBottomSheetsUtil().bottomSheet(
                                context: context,
                                listOfCategories: listOfCategories,
                                selectedCategoryCallBack: (cat) {
                                  refreshObj.categorySelected = cat;
                                  refreshPage.sink.add(refreshObj);
                                },
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: BioField(
                            bioController: textController,
                            title: AppLocalizations.of(context)!
                                .whatdoyouwanttoask,
                            onChanged: (text) {
                              refreshObj.content = text;
                              refreshPage.sink.add(refreshObj);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: InkWell(
                            onTap: () {
                              BottomSheetsUtil().addImageBottomSheet(
                                context,
                                image != null,
                                AppLocalizations.of(context)!
                                    .profilephotosetting,
                                AppLocalizations.of(context)!.setprofilephoto,
                                deleteCallBack: () {
                                  image = null;
                                  refreshObj.attachment = image;
                                  refreshPage.sink.add(refreshObj);
                                  Navigator.pop(context);
                                },
                                cameraCallBack: () async {
                                  image = await pickImage(ImageSource.camera);
                                  if (image == null || image!.path.isEmpty) {
                                    return;
                                  }
                                  refreshObj.attachment = image;
                                  refreshPage.sink.add(refreshObj);
                                },
                                galleryCallBack: () async {
                                  image = await pickImage(ImageSource.gallery);
                                  if (image == null || image!.path.isEmpty) {
                                    return;
                                  }
                                  refreshObj.attachment = image;
                                  refreshPage.sink.add(refreshObj);
                                },
                              );
                            },
                            child: Stack(
                              children: [
                                Image.asset(
                                  "assets/images/attach_placeholder.png",
                                  width: 70,
                                  height: 70,
                                ),
                                if (image != null)
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        image!,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                else
                                  const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          );
        });
  }

  bool validateFields(AddPostModel? post) {
    if (post == null) {
      return false;
    }

    if (post.content == null) {
      return false;
    }

    if (post.categorySelected == null) {
      return false;
    }

    return true;
  }

  Future<File> pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    return File(image?.path ?? "");
  }
}
