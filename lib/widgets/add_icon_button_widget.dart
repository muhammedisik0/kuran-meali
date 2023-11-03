import 'package:flutter/material.dart';
import 'package:kuran_meali/constants/color_constants.dart';

import 'custom_icon_button_widget.dart';

class AddIconButton extends StatelessWidget {
  const AddIconButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: ColorConstants.lightTeal,
      radius: 28,
      child: CustomIconButton(
        onPressed: onPressed,
        icon: const Icon(
          Icons.add,
          size: 28,
          color: ColorConstants.black,
        ),
      ),
    );
  }
}
