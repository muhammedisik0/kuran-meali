import 'package:flutter/material.dart';
import 'package:kuran_meali/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';
import '../../constants/path_constants.dart';
import '../../helpers/dialog_helper.dart';
import '../../models/surah_model.dart';
import '../base_widgets/custom_icon_button_widget.dart';

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
                onPressed: viewModel.previousSurah,
                icon: const Icon(Icons.keyboard_double_arrow_left),
              ),
              CustomIconButton(
                onPressed: () {
                  viewModel.pdfViewerController.previousPage();
                },
                icon: const Icon(Icons.navigate_before),
              ),
              const SizedBox(width: 10),
              const _SurahsIconButton(),
              const SizedBox(width: 10),
              CustomIconButton(
                onPressed: () {
                  viewModel.pdfViewerController.nextPage();
                },
                icon: const Icon(Icons.navigate_next),
              ),
              CustomIconButton(
                onPressed: viewModel.nextSurah,
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
  const _SurahsIconButton();

  Future<void> onTap(BuildContext context) async {
    final result = await DialogHelper.showSurahsDialog(context);
    if (result != null) {
      final selectedSurah = result as Surah;
      final HomeViewModel homeViewModel =
          // ignore: use_build_context_synchronously
          Provider.of<HomeViewModel>(context, listen: false);
      homeViewModel.goToSurah(selectedSurah.number);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Image.asset(PathConstants.icQuran, width: 36),
    );
  }
}
