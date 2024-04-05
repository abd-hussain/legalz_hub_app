import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legalz_hub_app/shared_widget/file_holder_field.dart';

class CertificateView extends StatefulWidget {
  final double width;
  final double height;
  final Function(File?, File?, File?) onChange;

  const CertificateView({
    super.key,
    required this.onChange,
    required this.width,
    this.height = 50,
  });

  @override
  State<CertificateView> createState() => _CertificateViewState();
}

class _CertificateViewState extends State<CertificateView> {
  ValueNotifier<File?> certificate1 = ValueNotifier<File?>(null);
  ValueNotifier<File?> certificate2 = ValueNotifier<File?>(null);
  ValueNotifier<File?> certificate3 = ValueNotifier<File?>(null);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<File?>(
            valueListenable: certificate1,
            builder: (context, snapshot, child) {
              return certView(
                  index: 1,
                  width: widget.width,
                  height: widget.height,
                  file: snapshot,
                  onAddFile: (file) {
                    certificate1.value = file;
                    widget.onChange(certificate1.value, certificate2.value,
                        certificate3.value);
                  },
                  onRemove: () {
                    certificate1.value = null;
                    widget.onChange(certificate1.value, certificate2.value,
                        certificate3.value);
                  });
            }),
        ValueListenableBuilder<File?>(
            valueListenable: certificate2,
            builder: (context, snapshot, child) {
              return certView(
                  index: 2,
                  width: widget.width,
                  height: widget.height,
                  file: snapshot,
                  onAddFile: (file) {
                    certificate2.value = file;
                    widget.onChange(certificate1.value, certificate2.value,
                        certificate3.value);
                  },
                  onRemove: () {
                    certificate2.value = null;
                    widget.onChange(certificate1.value, certificate2.value,
                        certificate3.value);
                  });
            }),
        ValueListenableBuilder<File?>(
            valueListenable: certificate3,
            builder: (context, snapshot, child) {
              return certView(
                  index: 3,
                  width: widget.width,
                  height: widget.height,
                  file: snapshot,
                  onAddFile: (file) {
                    certificate3.value = file;
                    widget.onChange(certificate1.value, certificate2.value,
                        certificate3.value);
                  },
                  onRemove: () {
                    certificate3.value = null;
                    widget.onChange(certificate1.value, certificate2.value,
                        certificate3.value);
                  });
            }),
      ],
    );
  }

  Widget certView({
    required int index,
    required double width,
    required double height,
    required File? file,
    required Function(File) onAddFile,
    required Function() onRemove,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FileHolderField(
          title: "${AppLocalizations.of(context)!.certificate} $index",
          width: width,
          height: height,
          currentFile: file,
          onAddFile: (file) {
            onAddFile(file);
          },
          onRemoveFile: () => onRemove(),
        ),
      ],
    );
  }
}
