import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legalz_hub_app/shared_widget/bottom_sheet_util.dart';

class ReportAttatchment extends StatefulWidget {
  const ReportAttatchment({
    super.key,
    required this.attach1,
    required this.attach2,
    required this.attach3,
  });
  final Function(File?) attach1;
  final Function(File?) attach2;
  final Function(File?) attach3;

  @override
  State<ReportAttatchment> createState() => _ReportAttatchmentState();
}

class _ReportAttatchmentState extends State<ReportAttatchment> {
  File? image1;
  File? image2;
  File? image3;

  Future<File> pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    return File(image?.path ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                BottomSheetsUtil().addImageBottomSheet(
                  context,
                  image1 != null,
                  AppLocalizations.of(context)!.profilephotosetting,
                  AppLocalizations.of(context)!.setprofilephoto,
                  deleteCallBack: () {
                    widget.attach1(null);
                    image1 = null;
                    setState(() {});
                    Navigator.pop(context);
                  },
                  cameraCallBack: () async {
                    image1 = await pickImage(ImageSource.camera);
                    if (image1 == null || image1!.path.isEmpty) {
                      return;
                    }
                    widget.attach1(image1);
                    setState(() {});
                  },
                  galleryCallBack: () async {
                    image1 = await pickImage(ImageSource.gallery);
                    if (image1 == null || image1!.path.isEmpty) {
                      return;
                    }
                    widget.attach1(image1);
                    setState(() {});
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
                  if (image1 != null)
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          image1!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  else
                    Container()
                ],
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                BottomSheetsUtil().addImageBottomSheet(
                  context,
                  image1 != null,
                  AppLocalizations.of(context)!.profilephotosetting,
                  AppLocalizations.of(context)!.setprofilephoto,
                  deleteCallBack: () {
                    widget.attach2(null);
                    image2 = null;
                    setState(() {});
                    Navigator.pop(context);
                  },
                  cameraCallBack: () async {
                    image2 = await pickImage(ImageSource.camera);
                    if (image2 == null || image2!.path.isEmpty) {
                      return;
                    }
                    setState(() {});
                    widget.attach2(image2);
                  },
                  galleryCallBack: () async {
                    image2 = await pickImage(ImageSource.gallery);
                    if (image2 == null || image2!.path.isEmpty) {
                      return;
                    }
                    setState(() {});
                    widget.attach2(image2);
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
                  if (image2 != null)
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          image2!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  else
                    Container(),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              BottomSheetsUtil().addImageBottomSheet(
                context,
                image1 != null,
                AppLocalizations.of(context)!.profilephotosetting,
                AppLocalizations.of(context)!.setprofilephoto,
                deleteCallBack: () {
                  widget.attach3(null);
                  image3 = null;
                  setState(() {});
                  Navigator.pop(context);
                },
                cameraCallBack: () async {
                  image3 = await pickImage(ImageSource.camera);
                  if (image3 == null || image3!.path.isEmpty) {
                    return;
                  }
                  setState(() {});
                  widget.attach3(image3);
                },
                galleryCallBack: () async {
                  image3 = await pickImage(ImageSource.gallery);
                  if (image3 == null || image3!.path.isEmpty) {
                    return;
                  }
                  setState(() {});
                  widget.attach3(image3);
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
                if (image3 != null)
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        image3!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                  Container(),
              ],
            ),
          ),
          Expanded(child: Container())
        ],
      ),
    );
  }
}
