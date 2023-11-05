import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

import '../constants/color_constants.dart';
import 'custom_icon_button_widget.dart';

class PageNavigation extends StatelessWidget {
  const PageNavigation({super.key, required this.pdfController});

  final PdfController pdfController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: ColorConstants.teal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          fivePagesBackIconButton,
          previousIconButton,
          const SizedBox(width: 20),
          nextIconButton,
          fivePagesForwardIconButton,
        ],
      ),
    );
  }

  Widget get previousIconButton {
    return CustomIconButton(
      onPressed: () {
        pdfController.previousPage(
          curve: Curves.ease,
          duration: const Duration(milliseconds: 100),
        );
      },
      icon: const Icon(Icons.navigate_before),
    );
  }

  Widget get nextIconButton {
    return CustomIconButton(
      onPressed: () {
        pdfController.nextPage(
          curve: Curves.ease,
          duration: const Duration(milliseconds: 100),
        );
      },
      icon: const Icon(Icons.navigate_next),
    );
  }

  Widget get fivePagesBackIconButton {
    return CustomIconButton(
      onPressed: () => pdfController.jumpToPage(pdfController.page - 5),
      icon: const Icon(Icons.keyboard_double_arrow_left),
    );
  }

  Widget get fivePagesForwardIconButton {
    return CustomIconButton(
      onPressed: () => pdfController.jumpToPage(pdfController.page + 5),
      icon: const Icon(Icons.keyboard_double_arrow_right),
    );
  }
}
