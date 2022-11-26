import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;

class ImageInput extends StatefulWidget {
  ImageInput(this.imagePickFn);

  final Function imagePickFn;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  final picker = ImagePicker();

  Future<void> _imagePicker() async {
    final imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 150,
      imageQuality: 50,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await pathProvider.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage =
        await File(imageFile.path).copy('${appDir.path}/$fileName');
    widget.imagePickFn(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundImage:
              _storedImage != null ? FileImage(_storedImage!) : null,
        ),
        TextButton.icon(
          onPressed: _imagePicker,
          icon: const Icon(Icons.image),
          label: const Text("Add Image"),
        ),
      ],
    );
  }
}
