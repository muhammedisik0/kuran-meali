import 'package:flutter/material.dart';
import 'package:kuran_meali/constants/color_constants.dart';

import '../helpers/dialog_helper.dart';
import '../models/note_model.dart';
import '../services/storage_service.dart';
import 'custom_icon_button_widget.dart';

class AddIconButton extends StatelessWidget {
  const AddIconButton({super.key, this.callback});

  final VoidCallback? callback;

  Future<void> onPressed(BuildContext context) async {
    final result = await DialogHelper.showAddNoteDialog(context) as List;
    final isAdded = result.first;
    if (isAdded) {
      final note = result.last as Note;
      final listOfNotes = StorageService.listOfNotes;
      listOfNotes.add(note);
      StorageService.listOfNotes = listOfNotes;
      if (callback != null) callback!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: ColorConstants.lightTeal,
      radius: 28,
      child: CustomIconButton(
        onPressed: () => onPressed(context),
        icon: const Icon(
          Icons.add,
          size: 28,
          color: ColorConstants.black,
        ),
      ),
    );
  }
}
