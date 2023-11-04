import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

import '../constants/color_constants.dart';
import '../constants/path_constants.dart';
import '../constants/route_constants.dart';
import '../constants/snackbar_text_constants.dart';
import '../constants/surah_constants.dart';
import '../constants/text_constants.dart';
import '../helpers/snackbar_helper.dart';
import '../models/surah_model.dart';
import '../services/storage_service.dart';
import 'custom_icon_button_widget.dart';
import 'pin_icon_button_widget.dart';

class PdfViewer extends StatefulWidget {
  PdfViewer(
    this.pdfController, {
    super.key,
    required this.currentSurah,
  });

  final PdfController pdfController;
  Surah currentSurah;

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  bool isPinned = true;

  @override
  void initState() {
    super.initState();
  }

  void detectSurah(int page) {
    final index = SurahConstants.listOfSurah.indexWhere((surah) {
      return page >= surah.startsFrom && page < surah.ends;
    });
    widget.currentSurah = SurahConstants.listOfSurah[index];
  }

  void onPageChanged(int value) {
    detectSurah(value);
    isPinned = value == StorageService.pageNumber ? true : false;
    setState(() {});
  }

  void onPinIconButtonPressed() {
    isPinned = true;
    StorageService.pageNumber = widget.pdfController.page;
    SnackBarHelper.showSnackBar(SnackBarTextConstants.pinnedPage);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return body;
  }

  Widget get body {
    return Stack(
      alignment: Alignment.center,
      children: [
        pdfSection,
        Positioned(
          top: 10,
          right: 16,
          child: PinIconButton(
            onPressed: onPinIconButtonPressed,
            isPinned: isPinned,
          ),
        ),
        Positioned(
          top: 20,
          left: 20,
          child: pageNumber,
        ),
      ],
    );
  }

  Widget get pdfSection {
    return Padding(
      padding: const EdgeInsets.only(bottom: 70),
      child: PdfView(
        onPageChanged: onPageChanged,
        controller: widget.pdfController,
        scrollDirection:
            StorageService.scrollDirection ? Axis.vertical : Axis.horizontal,
        builders: PdfViewBuilders<DefaultBuilderOptions>(
          options: const DefaultBuilderOptions(),
          documentLoaderBuilder: (_) => const Center(
            child: CircularProgressIndicator(color: ColorConstants.teal),
          ),
          pageLoaderBuilder: (_) {
            return const Center(
              child: CircularProgressIndicator(color: ColorConstants.lightTeal),
            );
          },
        ),
      ),
    );
  }

  Widget get pageNumber {
    return PdfPageNumber(
      controller: widget.pdfController,
      builder: (context, loadingState, page, pagesCount) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ColorConstants.lightTeal,
        ),
        child: Text(
          '$page/${pagesCount ?? 0}',
          style: const TextStyle(
            fontSize: 14,
            color: ColorConstants.black,
          ),
        ),
      ),
    );
  }
}
