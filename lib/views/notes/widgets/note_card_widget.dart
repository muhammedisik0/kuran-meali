import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:kuran_meali/view_models/notes_view_model.dart';
import 'package:provider/provider.dart';

import '../../../constants/color_constants.dart';
import '../../../constants/text_constants.dart';
import '../../../models/note_model.dart';

class NoteCard extends StatelessWidget {
  final int index;

  const NoteCard(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotesViewModel>(
      builder: (context, viewModel, child) {
        return Container(
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            border:
                Border(left: BorderSide(width: 4, color: ColorConstants.teal)),
          ),
          child: Card(
            elevation: 3,
            margin: const EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: _Title(viewModel.listOfNotes[index])),
                      _MoreIconButton(index: index),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: _Content(viewModel.listOfNotes[index]),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Title extends StatelessWidget {
  const _Title(this.note);

  final Note note;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      note.title,
      maxLines: 1,
      minFontSize: 14,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content(this.note);

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Text(
      note.content,
      style: const TextStyle(fontSize: 14),
    );
  }
}

class _MoreIconButton extends StatelessWidget {
  const _MoreIconButton({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<NotesViewModel>(
      builder: (context, viewModel, child) {
        return PopupMenuButton<String>(
          onSelected: (value) => value == 'edit'
              ? viewModel.onEditButtonPressed(context, index)
              : viewModel.onDeleteButtonPressed(context, index),
          icon: const Icon(Icons.more_vert, size: 20),
          splashRadius: null,
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'edit',
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Icon(Icons.edit, color: ColorConstants.black, size: 20),
                  SizedBox(width: 8),
                  Text(TextConstants.edit),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'delete',
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Icon(Icons.delete, color: ColorConstants.black, size: 20),
                  SizedBox(width: 8),
                  Text(TextConstants.delete),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
