import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

import '../constants/color_constants.dart';
import '../constants/path_constants.dart';
import '../helpers/dialog_helper.dart';
import '../models/surah_model.dart';

class SurahsIconButton extends StatelessWidget {
  const SurahsIconButton({super.key, required this.pdfController});

  final PdfController pdfController;

  Future<void> onTap(BuildContext context) async {
    final result = await DialogHelper.showSurahsDialog(context);
    if (result != null) {
      final selectedSurah = result as Surah;
      pdfController.jumpToPage(selectedSurah.startsFrom);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: CircleAvatar(
        radius: 31,
        backgroundColor: ColorConstants.white,
        child: CircleAvatar(
          radius: 28,
          backgroundColor: ColorConstants.teal,
          child: Image.asset(PathConstants.icQuran, width: 28),
        ),
      ),
    );
  }
}
