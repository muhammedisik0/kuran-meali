import 'package:flutter/material.dart';
import 'package:kuran_meali/constants/color_constants.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  final Function() onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      color: ColorConstants.white,
      highlightColor: ColorConstants.transparent,
      splashColor: ColorConstants.transparent,
      padding: EdgeInsets.zero,
    );
  }
}
