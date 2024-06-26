import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legalz_hub_app/shared_widget/bottom_sheet_util.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';
import 'package:legalz_hub_app/utils/constants/constant.dart';

class ImageHolderField extends StatelessWidget {
  const ImageHolderField({
    super.key,
    required this.onAddImage,
    required this.onDeleteImage,
    this.isFromNetwork = false,
    this.urlImage,
    this.hight = 180,
    this.width = 120,
  });
  final Function(File image) onAddImage;
  final Function() onDeleteImage;
  final bool isFromNetwork;
  final String? urlImage;
  final double hight;
  final double width;

  Future<File> _pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    return File(image?.path ?? "");
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<File?> imageController = ValueNotifier<File?>(null);
    File? image;
    return InkWell(
      onTap: () {
        BottomSheetsUtil().addImageBottomSheet(
          context,
          image?.path.isNotEmpty ?? false || urlImage != null,
          AppLocalizations.of(context)!.profilephotosetting,
          AppLocalizations.of(context)!.setprofilephoto,
          deleteCallBack: () {
            onDeleteImage();
            image = null;

            imageController.value = image;

            Navigator.pop(context);
          },
          cameraCallBack: () async {
            image = await _pickImage(ImageSource.camera);
            if (image?.path.isEmpty ?? true) {
              return;
            }
            if (!isFromNetwork) {
              imageController.value = image;
            }
            onAddImage(image!);
          },
          galleryCallBack: () async {
            image = await _pickImage(ImageSource.gallery);
            if (image?.path.isEmpty ?? true) {
              return;
            }
            if (!isFromNetwork) {
              imageController.value = image;
            }
            onAddImage(image!);
          },
        );
      },
      child: Container(
        height: hight,
        width: width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xffE8E8E8))),
        child: ValueListenableBuilder<File?>(
          valueListenable: imageController,
          builder: (context, snapshot, child) {
            return snapshot != null || urlImage != null
                ? isFromNetwork
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          AppConstant.imagesBaseURLForAttorney + urlImage!,
                          width: 100,
                          height: 115,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          snapshot!,
                          width: 100,
                          height: 115,
                          fit: BoxFit.cover,
                        ),
                      )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        title: AppLocalizations.of(context)!.picprofile,
                        fontSize: 12,
                        textAlign: TextAlign.center,
                        textColor: Colors.black,
                      ),
                      const Icon(
                        Icons.add,
                        color: Color(0xff444444),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
