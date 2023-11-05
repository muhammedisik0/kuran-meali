import 'package:flutter/material.dart';
import 'package:kuran_meali/constants/color_constants.dart';
import 'package:kuran_meali/constants/text_constants.dart';
import 'package:kuran_meali/widgets/add_icon_button_widget.dart';

import '../helpers/dialog_helper.dart';
import '../models/note_model.dart';
import '../services/storage_service.dart';
import '../widgets/note_card_widget.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late List<Note> listOfNotes;

  @override
  void initState() {
    super.initState();
    listOfNotes = StorageService.listOfNotes;
  }

  void updateNotes() {
    setState(() => listOfNotes = StorageService.listOfNotes);
  }

  Future<void> onEditPressed(int index) async {
    final note = listOfNotes[index];
    final result =
        await DialogHelper.showAddNoteDialog(context, isEdit: true, note: note);
    final isEdited = result.first;
    if (isEdited) {
      final note = result.last as Note;
      listOfNotes[index] = note;
      StorageService.listOfNotes = listOfNotes;
      setState(() {});
    }
  }

  Future<void> onDeletePressed(int index) async {
    final isConfirmed = await DialogHelper.showConfirmationDialog(context);
    if (isConfirmed) {
      listOfNotes.removeAt(index);
      StorageService.listOfNotes = listOfNotes;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: AddIconButton(callback: updateNotes),
    );
  }

  AppBar get appBar {
    return AppBar(
      backgroundColor: ColorConstants.teal,
      title: const Text(TextConstants.notes),
    );
  }

  Widget get body {
    return ListView.builder(
      itemCount: listOfNotes.length,
      itemBuilder: (context, index) {
        return NoteCard(
          onEdit: () => onEditPressed(index),
          onDelete: () => onDeletePressed(index),
          note: listOfNotes[index],
        );
      },
    );
  }
}
