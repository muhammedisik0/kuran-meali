import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

import '../constants/color_constants.dart';
import '../constants/path_constants.dart';
import '../constants/snackbar_text_constants.dart';
import '../constants/surah_constants.dart';
import '../constants/text_constants.dart';
import '../helpers/snackbar_helper.dart';
import '../models/surah_model.dart';
import '../services/storage_service.dart';
import '../widgets/common_widgets/add_icon_button_widget.dart';
import '../widgets/home_widgets/notes_icon_button_widget.dart';
import '../widgets/home_widgets/page_navigation_widget.dart';
import '../widgets/home_widgets/page_number_widget.dart';
import '../widgets/home_widgets/pdf_viewer_widget.dart';
import '../widgets/home_widgets/pin_icon_button_widget.dart';
import '../widgets/home_widgets/settings_icon_button_widget.dart';
import '../widgets/home_widgets/surahs_icon_button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PdfController pdfController;

  late final List<Surah> listOfSurahs;
  late Surah currentSurah;

  late int pinnedPage;
  bool isPinned = true;

  @override
  void initState() {
    super.initState();
    listOfSurahs = SurahConstants.listOfSurahs;
    currentSurah = listOfSurahs[StorageService.surahNumber - 1];
    pinnedPage = StorageService.pinnedPage;
    createPdfController();
  }

  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }

  void onPageChanged(int value) {
    detectSurah(value);
    checkIfPinned(value);
  }

  void checkIfPinned(int page) {
    final tempIsPinned = isPinned;
    isPinned = page == pinnedPage ? true : false;
    if (tempIsPinned != isPinned) setState(() {});
  }

  void createPdfController() {
    pdfController = PdfController(
      document: PdfDocument.openAsset(PathConstants.pdfQuran),
      initialPage: pinnedPage,
    );
  }

  void detectSurah(int page) {
    final index = listOfSurahs.indexWhere((surah) {
      return page >= surah.startsFrom && page < surah.ends;
    });
    final surah = listOfSurahs[index];
    if (surah.name != currentSurah.name) {
      currentSurah = surah;
      setState(() {});
    }
  }

  void onPinIconButtonPressed() {
    isPinned = true;
    pinnedPage = pdfController.page;
    StorageService.pinnedPage = pinnedPage;
    StorageService.surahNumber = currentSurah.number;
    SnackBarHelper.showSnackBar(SnackBarTextConstants.pinnedPage);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: ColorConstants.teal,
      centerTitle: true,
      title: Text('${currentSurah.name} ${TextConstants.surahOf}'),
      leading: const NotesIconButton(),
      actions: [
        SettingsIconButton(callback: (() => setState(() {}))),
      ],
    );
  }

  Widget buildBody() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 70),
          child: PdfViewer(
            onPageChanged: onPageChanged,
            pdfController: pdfController,
          ),
        ),
        Positioned(
          top: 10,
          right: 16,
          child: PinIconButton(
            onPressed: onPinIconButtonPressed,
            isPinned: isPinned,
          ),
        ),
        Positioned(
          top: 20,
          left: 20,
          child: PageNumber(pdfController: pdfController),
        ),
        const Positioned(
          bottom: 64,
          right: 16,
          child: AddIconButton(),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: PageNavigation(pdfController: pdfController),
        ),
        Positioned(
          bottom: 27,
          child: SurahsIconButton(pdfController: pdfController),
        ),
      ],
    );
  }
}
