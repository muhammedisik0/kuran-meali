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

  static String get surahLatestRead =>
      _storage.read(StorageKeyConstants.surahLatestRead) ?? 'Fâtiha';

  static set surahLatestRead(String value) =>
      _storage.write(StorageKeyConstants.surahLatestRead, value);

  static bool get scrollDirection =>
      _storage.read(StorageKeyConstants.scrollDirection) ?? true;

  static void setScrollDirection() =>
      _storage.write(StorageKeyConstants.scrollDirection, !scrollDirection);

  static List<Note> get listOfMyNotes {
    final jsonString = _storage.read(StorageKeyConstants.myNotes);
    late final List<Note> myNotes;
    myNotes = jsonString != null
        ? (jsonDecode(jsonString) as List<dynamic>)
            .map((note) => Note.fromJson(note))
            .toList()
        : [];
    return myNotes;
  }

  static set listOfMyNotes(List<Note> listOfMyNotes) {
    final jsonString =
        jsonEncode(listOfMyNotes.map((note) => note.toJson()).toList());
    _storage.write(StorageKeyConstants.myNotes, jsonString);
  }
}
