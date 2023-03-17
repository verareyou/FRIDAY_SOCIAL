import 'package:flutter/material.dart';
import 'package:socialapp/utils/colors.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final double paddi;
  final String hintText;
  final TextInputType textInputType;

  const TextFieldInput({
    super.key,
    required this.hintText,
    this.isPass = false,
    required this.textEditingController,
    required this.textInputType,
    this.paddi = 22,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      style: TextStyle(
        color: mainTextColor
      ),
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: lightTextColor,
        ),
        fillColor: Color.fromARGB(0, 198, 198, 198),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:
              const BorderSide(color: lightTextColor, style: BorderStyle.solid),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:
              const BorderSide(color: lightTextColor, style: BorderStyle.solid),
        ),
        filled: true,
        contentPadding: EdgeInsets.all(paddi),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
