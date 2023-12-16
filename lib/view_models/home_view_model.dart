import 'package:flutter/material.dart';
import 'package:kuran_meali/constants/surah_constants.dart';
import 'package:kuran_meali/models/surah_model.dart';
import 'package:kuran_meali/services/storage_service.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../constants/path_constants.dart';

class HomeViewModel extends ChangeNotifier {
  late final PdfViewerController _pdfViewerController;

  late int _currentSurahNumber;
  late int _pinnedPage;
  //int _pageNumber = 1;
  //int _pageCount = 0;

  PdfViewerController get pdfViewerController => _pdfViewerController;
  int get currentSurahNumber => _currentSurahNumber;
  int get pinnedPage => _pinnedPage;
  //int get pageNumber => _pageNumber;
  //int get pageCount => _pageCount;

  String get fileName => '${PathConstants.docs}/$currentSurahNumber.pdf';
  Surah get currentSurah =>
      SurahConstants.listOfSurahs[_currentSurahNumber - 1];

  HomeViewModel() {
    _currentSurahNumber = StorageService.surahNumber;
    _pinnedPage = StorageService.pinnedPage;
    _pdfViewerController = PdfViewerController();
    _pdfViewerController.jumpToPage(_pinnedPage);
  }

  /*void onPageChanged(PdfPageChangedDetails details) {
    _pageNumber = details.newPageNumber;
    notifyListeners();
  }*/

  void nextSurah() {
    if (_currentSurahNumber < 114) _currentSurahNumber += 1;
    notifyListeners();
  }

  void previousSurah() {
    if (_currentSurahNumber > 1) _currentSurahNumber -= 1;
    notifyListeners();
  }

  void goToSurah(int value) {
    _currentSurahNumber = value;
    notifyListeners();
  }

  /*void resetPageInfo() {
    _pageNumber = 1;
    _pageCount = _pdfViewerController.pageCount;
    notifyListeners();
  }*/
}
