import 'package:flutter/material.dart';
import 'package:kuran_meali/constants/app_constants.dart';

import '../../constants/color_constants.dart';
import '../../constants/text_constants.dart';

class VersionNumber extends StatelessWidget {
  const VersionNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '${TextConstants.version} ${AppConstants.appVersion}',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: ColorConstants.mediumGray,
      ),
    );
  }
}
