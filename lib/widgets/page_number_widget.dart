import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

import '../constants/color_constants.dart';

class PageNumber extends StatelessWidget {
  const PageNumber({super.key, required this.pdfController});

  final PdfController pdfController;

  @override
  Widget build(BuildContext context) {
    return PdfPageNumber(
      controller: pdfController,
      builder: (context, loadingState, page, pagesCount) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ColorConstants.lightTeal,
        ),
        child: Text(
          '$page/${pagesCount ?? 0}',
          style: const TextStyle(fontSize: 14, color: ColorConstants.black),
        ),
      ),
    );
  }
}
