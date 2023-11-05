import 'package:flutter/material.dart';
import 'package:kuran_meali/constants/color_constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.maxLines,
    this.autoFocus,
    this.inputAction,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final int? maxLines;
  final bool? autoFocus;
  final TextInputAction? inputAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: TextField(
        controller: controller,
        autofocus: autoFocus ?? false,
        textInputAction: inputAction,
        cursorColor: ColorConstants.grey,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          labelText: labelText,
          alignLabelWithHint: true,
          labelStyle: const TextStyle(
            color: ColorConstants.grey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: ColorConstants.paleGrey,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 0),
          ),
          hintStyle: const TextStyle(
            color: ColorConstants.grey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
