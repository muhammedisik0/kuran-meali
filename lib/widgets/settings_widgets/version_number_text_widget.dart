import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';
import '../../constants/text_constants.dart';

class VersionNumber extends StatelessWidget {
  const VersionNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '${TextConstants.version} 1.1.0',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: ColorConstants.mediumGray,
      ),
    );
  }
}
