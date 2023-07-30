import 'package:get_storage/get_storage.dart';

class LocalStorageService {
  static final _storage = GetStorage("Qur'an");

  static int get pageNumber => _storage.read('initialPage') ?? 1;

  static set pageNumber(int value) => _storage.write('initialPage', value);
}
