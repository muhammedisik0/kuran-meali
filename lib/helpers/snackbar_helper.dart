import 'package:flutter/material.dart';
import 'package:kuran_meali/constants/color_constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../constants/path_constants.dart';
import '../constants/snackbar_text_constants.dart';

class SnackBarHelper {
  static void showSnackBar(BuildContext context, String text) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(
        messagePadding: const EdgeInsets.symmetric(horizontal: 20),
        message: SnackBarMessageConstants.pinnedPage,
        backgroundColor: ColorConstants.lightTeal,
        icon: Image.asset(PathConstants.icQuran, width: 48),
        iconPositionLeft: 20,
        iconRotationAngle: 0,
        textStyle: const TextStyle(color: ColorConstants.black, fontSize: 16),
      ),
      displayDuration: const Duration(milliseconds: 1500),
    );
  }
}
