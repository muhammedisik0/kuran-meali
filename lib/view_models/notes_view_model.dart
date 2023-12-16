import 'package:flutter/material.dart';

import '../helpers/dialog_helper.dart';
import '../models/note_model.dart';
import '../services/storage_service.dart';

class NotesViewModel extends ChangeNotifier {
  late List<Note> _listOfNotes;

  List<Note> get listOfNotes => _listOfNotes;

  NotesViewModel() {
    _listOfNotes = StorageService.listOfNotes;
  }

  Future<void> onAddIconButtonPressed(BuildContext context) async {
    final result = await DialogHelper.showAddNoteDialog(context) as List;
    final bool isAdded = result.first;
    if (isAdded) {
      final note = result.last as Note;
      _listOfNotes.add(note);
      StorageService.listOfNotes = listOfNotes;
      notifyListeners();
    }
  }

  Future<void> onDeleteButtonPressed(BuildContext context, int index) async {
    final isConfirmed = await DialogHelper.showConfirmationDialog(context);
    if (isConfirmed) {
      _listOfNotes.removeAt(index);
      StorageService.listOfNotes = _listOfNotes;
      notifyListeners();
    }
  }

  Future<void> onEditButtonPressed(BuildContext context, int index) async {
    final Note note = _listOfNotes[index];
    final result =
        await DialogHelper.showAddNoteDialog(context, isEdit: true, note: note);
    final bool isEdited = result.first;
    if (isEdited) {
      final note = result.last as Note;
      _listOfNotes[index] = note;
      StorageService.listOfNotes = _listOfNotes;
      notifyListeners();
    }
  }
}
