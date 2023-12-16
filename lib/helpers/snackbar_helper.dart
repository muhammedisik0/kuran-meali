import 'package:flutter/material.dart';
import 'package:kuran_meali/constants/color_constants.dart';

class SnackBarHelper {
  static void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      backgroundColor: ColorConstants.dodgerBlue,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
        style: const TextStyle(fontSize: 16, color: ColorConstants.white),
      ),
    );

    _show(context, snackBar);
  }

  static void _show(BuildContext context, SnackBar snackBar) {
    final scaffoldMessengerState = ScaffoldMessenger.of(context);
    if (scaffoldMessengerState.mounted) {
      scaffoldMessengerState.hideCurrentSnackBar();
    }
    scaffoldMessengerState.showSnackBar(snackBar);
  }
}
