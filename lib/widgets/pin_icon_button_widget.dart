import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import 'custom_icon_button_widget.dart';

class PinIconButton extends StatelessWidget {
  const PinIconButton({
    super.key,
    required this.onPressed,
    required this.isPinned,
  });

  final VoidCallback onPressed;
  final bool isPinned;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor:
          isPinned ? ColorConstants.transparent : ColorConstants.lightTeal,
      child: CustomIconButton(
        onPressed: isPinned ? () {} : onPressed,
        icon: const Icon(
          Icons.push_pin,
          size: 20,
          color: ColorConstants.black,
        ),
      ),
    );
  }
}
