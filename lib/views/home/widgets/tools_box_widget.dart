import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/snackbar_text_constants.dart';
import '../../../helpers/snackbar_helper.dart';
import '../../../services/storage_service.dart';
import '../../../view_models/home_view_model.dart';
import '../../../widgets/base_widgets/custom_icon_button_widget.dart';
import '../../../widgets/common_widgets/add_icon_button_widget.dart';
import '../../../widgets/common_widgets/vertical_divider_widget.dart';

class ToolsBox extends StatelessWidget {
  const ToolsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: ColorConstants.teal,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PinIconButton(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: IVerticalDivider(),
          ),
          AddIconButton(),
        ],
      ),
    );
  }
}

class _PinIconButton extends StatelessWidget {
  const _PinIconButton();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return CustomIconButton(
          onPressed: () => onPinIconButtonPressed(
              context,
              viewModel.currentSurahNumber,
              viewModel.pdfViewerController.pageNumber),
          icon: const Icon(Icons.push_pin_outlined),
        );
      },
    );
  }

  void onPinIconButtonPressed(
      BuildContext context, int surahNumber, pageNumber) {
    StorageService.surahNumber = surahNumber;
    StorageService.pinnedPage = pageNumber;
    SnackBarHelper.showSnackBar(context, SnackBarMessageConstants.pinnedPage);
  }
}
