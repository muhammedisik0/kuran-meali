import 'package:flutter/material.dart';
import 'package:kuran_meali/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/route_constants.dart';
import '../../../widgets/base_widgets/custom_icon_button_widget.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.teal,
      centerTitle: true,
      title: Consumer<HomeViewModel>(builder: (context, viewModel, child) {
        return Text('${viewModel.currentSurah.name} Sûresi');
      }),
      leading: const _NotesIconButton(),
      actions: const [_SettingsIconButton()],
    );
  }
}

class _NotesIconButton extends StatelessWidget {
  const _NotesIconButton();

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onPressed: () => Navigator.pushNamed(context, RouteConstants.notes),
      icon: const Icon(Icons.assignment),
    );
  }
}

class _SettingsIconButton extends StatelessWidget {
  const _SettingsIconButton();

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onPressed: () => Navigator.pushNamed(context, RouteConstants.settings),
      icon: const Icon(Icons.settings),
    );
  }
}
