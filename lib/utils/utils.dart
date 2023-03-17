import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";

// dimensions
const webScreenSize = 600;

// image
pickImage(ImageSource source, {required bool isPost}) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(
      source: source, imageQuality: isPost ? 75 : 40);

  if (_file != null) {
    return _file.readAsBytes();
  }
  print("No image selected");
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
