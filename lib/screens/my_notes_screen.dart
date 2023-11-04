import 'package:flutter/material.dart';
import 'package:kuran_meali/constants/color_constants.dart';
import 'package:kuran_meali/constants/text_constants.dart';
import 'package:kuran_meali/widgets/add_icon_button_widget.dart';

import '../helpers/dialog_helper.dart';
import '../models/note_model.dart';
import '../services/storage_service.dart';
import '../widgets/note_card_widget.dart';

class MyNotesScreen extends StatefulWidget {
  const MyNotesScreen({super.key});

  @override
  State<MyNotesScreen> createState() => _MyNotesScreenState();
}

class _MyNotesScreenState extends State<MyNotesScreen> {
  List<Note> listOfMyNotes = [];

  @override
  void initState() {
    super.initState();
    listOfMyNotes = StorageService.listOfMyNotes;
  }

  Future<void> onAddPressed() async {
    final result = await DialogHelper.showAddNoteDialog(context) as List;
    final isAdded = result.first;
    if (isAdded) {
      final note = result.last as Note;
      listOfMyNotes.add(note);
      StorageService.listOfMyNotes = listOfMyNotes;
      setState(() {});
    }
  }

  Future<void> onEditPressed(int index) async {
    final note = listOfMyNotes[index];
    final result =
        await DialogHelper.showAddNoteDialog(context, isEdit: true, note: note);
    final isEdited = result.first;
    if (isEdited) {
      final note = result.last as Note;
      listOfMyNotes[index] = note;
      StorageService.listOfMyNotes = listOfMyNotes;
      setState(() {});
    }
  }

  Future<void> onDeletePressed(int index) async {
    final isConfirmed = await DialogHelper.showConfirmationDialog(context);
    if (isConfirmed) {
      listOfMyNotes.removeAt(index);
      StorageService.listOfMyNotes = listOfMyNotes;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: AddIconButton(onPressed: onAddPressed),
    );
  }

  AppBar get appBar {
    print('appbar--------');
    return AppBar(
      backgroundColor: ColorConstants.teal,
      title: const Text(TextConstants.myNotes),
    );
  }

  Widget get body {
    return ListView.builder(
      itemCount: listOfMyNotes.length,
      itemBuilder: (context, index) {
        return NoteCard(
          onEdit: () => onEditPressed(index),
          onDelete: () => onDeletePressed(index),
          note: listOfMyNotes[index],
        );
      },
    );
  }
}
