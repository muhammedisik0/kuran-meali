import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

import '../../constants/color_constants.dart';
import '../../services/storage_service.dart';

class PdfViewer extends StatelessWidget {
  const PdfViewer({
    super.key,
    required this.onPageChanged,
    required this.pdfController,
  });

  final Function(int) onPageChanged;
  final PdfController pdfController;

  @override
  Widget build(BuildContext context) {
    return PdfView(
      onPageChanged: onPageChanged,
      controller: pdfController,
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
    );
  }
}
