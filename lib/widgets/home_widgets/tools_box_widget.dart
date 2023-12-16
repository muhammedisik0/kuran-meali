import 'package:flutter/material.dart';
import 'package:kuran_meali/view_models/home_view_model.dart';
import 'package:kuran_meali/widgets/common_widgets/vertical_divider_widget.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';
import '../../constants/snackbar_text_constants.dart';
import '../../helpers/snackbar_helper.dart';
import '../../services/storage_service.dart';
import '../base_widgets/custom_icon_button_widget.dart';
import '../common_widgets/add_icon_button_widget.dart';

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

  void onPinIconButtonPressed(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);
    StorageService.surahNumber = viewModel.currentSurahNumber;
    StorageService.pinnedPage = viewModel.pdfViewerController.pageNumber;
    SnackBarHelper.showSnackBar(context, SnackBarMessageConstants.pinnedPage);
  }

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onPressed: () => onPinIconButtonPressed(context),
      icon: const Icon(Icons.push_pin_outlined),
    );
  }
}
