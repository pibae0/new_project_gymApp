import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gym_app_project/widgets/buttons/custom_button.dart';

class ImagePickerHelper {
  Future<File?> pickImageFromFiles() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      return File(result.files.single.path!);
    }
    return null;
  }
}

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({
    super.key,
    required this.imageNotifier,
    required this.onPickImageFromFiles,
  });

  final ValueNotifier<File?> imageNotifier;

  final Future<File?> Function() onPickImageFromFiles;

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // adicinado imagem padrao caso nao tenha imagem
          ValueListenableBuilder<File?>(
            valueListenable: widget.imageNotifier,
            builder: (context, image, child) {
              return image != null
                  ? Image.file(
                      image,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    )
                  : const Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.white,
                    );
            },
          ),

          const SizedBox(height: 16),
          CustomButton(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            onPressed: () async {
              final pickedImage = await widget.onPickImageFromFiles();
              if (pickedImage != null) {
                widget.imageNotifier.value = pickedImage;
              }
            },
            text: 'Selecione a imagem',
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
