import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_models/notes_view_model.dart';
import '../base_widgets/custom_icon_button_widget.dart';

class AddIconButton extends StatelessWidget {
  const AddIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotesViewModel>(
      builder: (context, viewModel, child) {
        return CustomIconButton(
          onPressed: () => viewModel.onAddIconButtonPressed(context),
          icon: const Icon(Icons.add),
        );
      },
    );
  }
}
