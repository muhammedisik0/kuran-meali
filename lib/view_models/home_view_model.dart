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

  HomeViewModel() {
    _currentSurahNumber = StorageService.surahNumber;
    _pinnedPage = StorageService.pinnedPage;
    _pdfViewerController = PdfViewerController();
    _pdfViewerController.jumpToPage(_pinnedPage);
  }

  Surah get currentSurah =>
      SurahConstants.listOfSurahs[_currentSurahNumber - 1];
  int get currentSurahNumber => _currentSurahNumber;
  String get fileName => '${PathConstants.docs}/$currentSurahNumber.pdf';
  PdfViewerController get pdfViewerController => _pdfViewerController;
  int get pinnedPage => _pinnedPage;
  int get _currentPage => _pdfViewerController.pageNumber;
  int get _pageCount => _pdfViewerController.pageCount;

  void _checkIfFirstSurah() {
    if (_currentSurahNumber > 1) _currentSurahNumber--;
  }

  void _checkIfLastSurah() {
    if (_currentSurahNumber < 114) _currentSurahNumber++;
  }

  void goToSurah(int value) {
    _currentSurahNumber = value;
    notifyListeners();
  }

  void jumpTo5PagesBack() {
    final int targetPage = _currentPage - 5;
    if (targetPage < 1) {
      _pdfViewerController.firstPage();
    } else {
      _pdfViewerController.jumpToPage(targetPage);
    }
  }

  void jumpTo5PagesForward() {
    final int targetPage = _currentPage + 5;
    if (targetPage > _pageCount) {
      _pdfViewerController.lastPage();
    } else {
      _pdfViewerController.jumpToPage(targetPage);
    }
  }

  void nextPage() {
    if (_currentPage == _pageCount) {
      _checkIfLastSurah();
      notifyListeners();
    } else {
      _pdfViewerController.nextPage();
    }
  }

  void previousPage() {
    if (_currentPage == 1) {
      _checkIfFirstSurah();
      notifyListeners();
    } else {
      _pdfViewerController.previousPage();
    }
  }
}
