import 'package:flutter/material.dart';
import 'package:kuran_meali/constants/color_constants.dart';
import 'package:kuran_meali/view_models/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../common_widgets/overlay_entry_widget.dart';

class PdfViewer extends StatelessWidget {
  const PdfViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      alignment: Alignment.center,
      children: [
        _PdfViewer(),
        Positioned(bottom: 10, left: 20, child: _SurahInfo()),
      ],
    );
  }
}

class _PdfViewer extends StatefulWidget {
  const _PdfViewer();

  @override
  State<_PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<_PdfViewer> {
  OverlayEntry? _overlayEntry;

  void _showContextMenu(
      BuildContext context,
      PdfTextSelectionChangedDetails details,
      PdfViewerController pdfViewerController) {
    final OverlayState overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => OverlayEntryWidget(
        pdfViewerController: pdfViewerController,
        details: details,
      ),
    );
    overlayState.insert(_overlayEntry!);
  }

  void _onTextSelectionChanged(
      BuildContext context,
      PdfTextSelectionChangedDetails details,
      PdfViewerController pdfViewerController) {
    if (details.selectedText == null && _overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    } else if (details.selectedText != null && _overlayEntry == null) {
      _showContextMenu(context, details, pdfViewerController);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return SfPdfViewer.asset(
          viewModel.fileName,
          //onPageChanged: viewModel.onPageChanged,
          //onDocumentLoaded: (details) => viewModel.onDocumentLoaded,
          onTextSelectionChanged: (details) => _onTextSelectionChanged(
              context, details, viewModel.pdfViewerController),
          controller: viewModel.pdfViewerController,
          canShowScrollHead: false, // page number in scroll position
          canShowScrollStatus: true, // page number while scrolling
          canShowPageLoadingIndicator: true,
          enableTextSelection: true,
          enableDoubleTapZooming: true,
          pageLayoutMode: PdfPageLayoutMode.continuous,
        );
      },
    );
  }
}

class _SurahInfo extends StatelessWidget {
  const _SurahInfo();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.amber[300],
          ),
          child: Text(
            '${viewModel.currentSurah.number}:${viewModel.currentSurah.countOfVerses}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ColorConstants.black,
            ),
          ),
        );
      },
    );
  }
}

/*class _PageNumber extends StatelessWidget {
  const _PageNumber();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: const ShapeDecoration(
            shape: StadiumBorder(),
            color: ColorConstants.teal,
          ),
          child: Text(
            '${viewModel.pageNumber}/${viewModel.pageCount}',
            style: const TextStyle(color: ColorConstants.white, fontSize: 14),
          ),
        );
      },
    );
  }
}*/
