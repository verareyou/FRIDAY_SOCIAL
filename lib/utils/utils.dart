import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";

// dimensions
const webScreenSize = 600;

// image
pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if(_file != null) {
    return _file.readAsBytes();
  }
  print("No image selected");
}