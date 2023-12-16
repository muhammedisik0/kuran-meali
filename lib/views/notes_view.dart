import 'package:flutter/material.dart';
import 'package:kuran_meali/view_models/notes_view_model.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../constants/text_constants.dart';
import '../widgets/common_widgets/add_icon_button_widget.dart';
import '../widgets/notes_widgets/note_card_widget.dart';

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _IAppBar(),
      body: _NotesListView(),
      floatingActionButton: _AddIconButton(),
    );
  }
}

class _IAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _IAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.teal,
      title: const Text(TextConstants.notes),
    );
  }
}

class _NotesListView extends StatelessWidget {
  const _NotesListView();

  @override
  Widget build(BuildContext context) {
    return Consumer<NotesViewModel>(
      builder: (context, viewModel, child) {
        return ListView.builder(
          itemCount: viewModel.listOfNotes.length,
          itemBuilder: (context, index) => NoteCard(index),
        );
      },
    );
  }
}

class _AddIconButton extends StatelessWidget {
  const _AddIconButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: const BoxDecoration(
        color: ColorConstants.teal,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: const AddIconButton(),
    );
  }
}
