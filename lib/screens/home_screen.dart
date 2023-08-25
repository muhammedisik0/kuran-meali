import 'package:flutter/material.dart';
import 'package:kuran_meali/screens/settings_screen.dart';
import 'package:kuran_meali/widgets/custom_icon_button.dart';
import 'package:pdfx/pdfx.dart';

import '../constants/surah_constants.dart';
import '../helpers/dialog_helper.dart';
import '../models/surah_model.dart';
import '../services/local_storage_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PdfController pdfController;
  late Surah currentSurah;

  @override
  void initState() {
    super.initState();
    createPdfController();
    detectSurah(pdfController.initialPage);
  }

  void createPdfController() {
    pdfController = PdfController(
      document: PdfDocument.openAsset('assets/quran-interpretation.pdf'),
      initialPage: LocalStorageService.pageNumber,
    );
  }

  void detectSurah(int page) {
    final index = SurahConstants.listOfSurah.indexWhere((surah) {
      return page >= surah.startsFrom && page < surah.ends;
    });
    currentSurah = SurahConstants.listOfSurah[index];
    setState(() {});
  }

  Future<void> navigateToSettingsScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
    setState(() {});
  }

  void onPageChanged(int value) {
    LocalStorageService.pageNumber = value;
    detectSurah(pdfController.page);
  }

  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: body,
    );
  }

  AppBar get appBar {
    return AppBar(
      backgroundColor: Colors.teal,
      title: Text('${currentSurah.name} Suresi'),
      centerTitle: true,
      leading: settingsIconButton,
    );
  }

  Widget get settingsIconButton {
    return CustomIconButton(
      onPressed: navigateToSettingsScreen,
      icon: const Icon(Icons.menu),
    );
  }

  Widget get body {
    return Stack(
      alignment: Alignment.center,
      children: [
        pdfSection,
        Positioned(
          bottom: 84,
          right: 20,
          child: pageNumber,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: pageNavigationSection,
        ),
        Positioned(
          bottom: 27,
          child: allSurahButton,
        ),
      ],
    );
  }

  Widget get pdfSection {
    return Padding(
      padding: const EdgeInsets.only(bottom: 69),
      child: PdfView(
        onPageChanged: onPageChanged,
        controller: pdfController,
        scrollDirection: LocalStorageService.scrollDirection ? Axis.vertical : Axis.horizontal,
        builders: PdfViewBuilders<DefaultBuilderOptions>(
          options: const DefaultBuilderOptions(),
          documentLoaderBuilder: (_) => const Center(
            child: CircularProgressIndicator(
              color: Colors.teal,
            ),
          ),
          pageLoaderBuilder: (_) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget get pageNumber {
    return PdfPageNumber(
      controller: pdfController,
      builder: (_, loadingState, page, pagesCount) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.teal[100],
        ),
        child: Text(
          '$page/${pagesCount ?? 0}',
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget get pageNavigationSection {
    return Container(
      height: 54,
      color: Colors.teal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          fivePagesBackIconButton,
          previousIconButton,
          const SizedBox(width: 20),
          nextIconButton,
          fivePagesForwardIconButton,
        ],
      ),
    );
  }

  Widget get previousIconButton {
    return CustomIconButton(
      onPressed: () {
        pdfController.previousPage(
          curve: Curves.ease,
          duration: const Duration(milliseconds: 100),
        );
      },
      icon: const Icon(Icons.navigate_before),
    );
  }

  Widget get nextIconButton {
    return CustomIconButton(
      onPressed: () {
        pdfController.nextPage(
          curve: Curves.ease,
          duration: const Duration(milliseconds: 100),
        );
      },
      icon: const Icon(Icons.navigate_next),
    );
  }

  Widget get fivePagesBackIconButton {
    return CustomIconButton(
      onPressed: () => pdfController.jumpToPage(pdfController.page - 5),
      icon: const Icon(Icons.keyboard_double_arrow_left),
    );
  }

  Widget get fivePagesForwardIconButton {
    return CustomIconButton(
      onPressed: () => pdfController.jumpToPage(pdfController.page + 5),
      icon: const Icon(Icons.keyboard_double_arrow_right),
    );
  }

  Widget get allSurahButton {
    return GestureDetector(
      onTap: () => DialogHelper.showSurahDialog(context, pdfController),
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: 27,
          backgroundColor: Colors.teal,
          child: Image.asset(
            'assets/images/quran.png',
            width: 27,
          ),
        ),
      ),
    );
  }
}
