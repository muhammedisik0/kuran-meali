import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:kuran_meali/constants/storage_key_constants.dart';
import '../models/note_model.dart';

class StorageService {
  static final _storage = GetStorage(StorageKeyConstants.quran);

  static int get pinnedPage =>
      _storage.read(StorageKeyConstants.initialPage) ?? 1;

  static set pinnedPage(int value) =>
      _storage.write(StorageKeyConstants.initialPage, value);

  static int get surahNumber =>
      _storage.read(StorageKeyConstants.surahNumber) ?? 1;

  static set surahNumber(int value) =>
      _storage.write(StorageKeyConstants.surahNumber, value);

  static bool get scrollDirection =>
      _storage.read(StorageKeyConstants.scrollDirection) ?? true;

  static void setScrollDirection() =>
      _storage.write(StorageKeyConstants.scrollDirection, !scrollDirection);

  static List<Note> get listOfNotes {
    final jsonString = _storage.read(StorageKeyConstants.notes);
    late final List<Note> notes;
    notes = jsonString != null
        ? (jsonDecode(jsonString) as List<dynamic>)
            .map((note) => Note.fromJson(note))
            .toList()
        : [];
    return notes;
  }

  static set listOfNotes(List<Note> listOfNotes) {
    final jsonString =
        jsonEncode(listOfNotes.map((note) => note.toJson()).toList());
    _storage.write(StorageKeyConstants.notes, jsonString);
  }
}
