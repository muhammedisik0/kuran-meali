import 'package:get_storage/get_storage.dart';

class LocalStorageService {
  static final _storage = GetStorage("Quran");

  static int get pageNumber => _storage.read('initialPage') ?? 1;

  static set pageNumber(int value) => _storage.write('initialPage', value);

  static bool get scrollDirection => _storage.read('scrollDirection') ?? true;

  static void setScrollDirection() => _storage.write('scrollDirection', !scrollDirection);
}
