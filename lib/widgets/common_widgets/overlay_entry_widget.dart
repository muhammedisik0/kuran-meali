import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class OverlayEntryWidget extends StatelessWidget {
  const OverlayEntryWidget({
    super.key,
    required this.pdfViewerController,
    required this.details,
  });

  final PdfViewerController pdfViewerController;
  final PdfTextSelectionChangedDetails details;

  void onCopyButtonPressed() {
    String selectedText = removeExcessSpaces(details.selectedText!);
    Clipboard.setData(ClipboardData(text: selectedText));
    pdfViewerController.clearSelection();
  }

  String removeExcessSpaces(String text) {
    // Replace multiple whitespace characters with a single space
    final String textWithSingleSpace = text.replaceAll(RegExp(r'\s{2,}'), ' ');
    return textWithSingleSpace;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: details.globalSelectedRegion!.center.dy - 55,
      left: details.globalSelectedRegion!.bottomLeft.dx,
      child: MaterialButton(
        onPressed: onCopyButtonPressed,
        color: Colors.white,
        elevation: 10,
        child: const Text('Kopyala', style: TextStyle(fontSize: 17)),
      ),
    );
  }
}
