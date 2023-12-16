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

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: details.globalSelectedRegion!.center.dy - 55,
      left: details.globalSelectedRegion!.bottomLeft.dx,
      child: MaterialButton(
        onPressed: () {
          Clipboard.setData(ClipboardData(text: details.selectedText!));
          pdfViewerController.clearSelection();
        },
        color: Colors.white,
        elevation: 10,
        child: const Text('Kopyala', style: TextStyle(fontSize: 17)),
      ),
    );
  }
}
