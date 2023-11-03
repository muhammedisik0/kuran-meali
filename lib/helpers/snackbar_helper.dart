import 'package:flutter/material.dart';
import 'package:kuran_meali/constants/color_constants.dart';

import '../utils/globals.dart';

class SnackBarHelper {
  static void showSnackBar(String text) {
    final snackBar = SnackBar(
      backgroundColor: ColorConstants.lightTeal,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
        style: const TextStyle(fontSize: 16, color: ColorConstants.black),
      ),
    );

    _show(snackBar);
  }

  static void _show(SnackBar snackBar) {
    final scaffoldMessengerState =
        ScaffoldMessenger.of(navigatorKey.currentContext!);
    if (scaffoldMessengerState.mounted) {
      scaffoldMessengerState.hideCurrentSnackBar();
    }
    scaffoldMessengerState.showSnackBar(snackBar);
  }
}
