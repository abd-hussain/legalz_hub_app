import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:legalz_hub_app/shared_widget/custom_text.dart';

class FileHolderField extends StatefulWidget {
  final String title;
  final double width;
  final double height;

  final File? currentFile;
  final Function(File image) onAddFile;
  final Function() onRemoveFile;

  const FileHolderField({
    super.key,
    required this.onAddFile,
    required this.title,
    required this.currentFile,
    required this.onRemoveFile,
    required this.width,
    this.height = 50,
  });

  @override
  State<FileHolderField> createState() => _FileHolderFieldState();
}

class _FileHolderFieldState extends State<FileHolderField> {
  ValueNotifier<File?> fileController = ValueNotifier<File?>(null);

  @override
  void initState() {
    if (widget.currentFile != null) {
      fileController.value = widget.currentFile;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          if (fileController.value == null) {
            try {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['jpg', 'pdf', 'doc'],
              );

              if (result != null) {
                fileController.value = File(result.files.single.path!);
                widget.onAddFile(File(result.files.single.path!));
              }
            } catch (error) {
              debugPrint(error.toString());
              debugPrint("Can not Upload");
            }
          } else {
            fileController.value = null;
            widget.onRemoveFile();
          }
        },
        child: ValueListenableBuilder<File?>(
            valueListenable: fileController,
            builder: (context, snapshot, child) {
              return Container(
                height: widget.height,
                width: widget.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: snapshot != null
                        ? const Color(0xff034061)
                        : const Color(0xffe0e0e0),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      title: widget.title,
                      fontSize: 12,
                      textAlign: TextAlign.center,
                      textColor: Colors.black,
                    ),
                    snapshot != null
                        ? const Icon(
                            Icons.remove,
                            color: Color(0xff444444),
                          )
                        : const Icon(
                            Icons.add,
                            color: Color(0xff444444),
                          ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
