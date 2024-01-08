import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/path_constants.dart';
import '../../../helpers/bottom_sheet_helper.dart';
import '../../../models/surah_model.dart';
import '../../../view_models/home_view_model.dart';
import '../../../widgets/base_widgets/custom_icon_button_widget.dart';

class PageNavigationBar extends StatelessWidget {
  const PageNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        color: ColorConstants.teal,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomIconButton(
                onPressed: viewModel.jumpTo5PagesBack,
                icon: const Icon(Icons.keyboard_double_arrow_left),
              ),
              CustomIconButton(
                onPressed: viewModel.previousPage,
                icon: const Icon(Icons.navigate_before),
              ),
              const SizedBox(width: 10),
              _SurahsIconButton(
                  callback: (value) => viewModel.goToSurah(value)),
              const SizedBox(width: 10),
              CustomIconButton(
                onPressed: viewModel.nextPage,
                icon: const Icon(Icons.navigate_next),
              ),
              CustomIconButton(
                onPressed: viewModel.jumpTo5PagesForward,
                icon: const Icon(Icons.keyboard_double_arrow_right),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SurahsIconButton extends StatelessWidget {
  final Function(int value) callback;

  const _SurahsIconButton({required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Image.asset(PathConstants.icQuran, width: 36),
    );
  }

  Future<void> onTap(BuildContext context) async {
    final result = await BottomSheetHelper.showSurahsBottomSheet(context);
    if (result != null) {
      final selectedSurah = result as Surah;
      callback(selectedSurah.number);
    }
  }
}
