import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

import '../constants/surah_constants.dart';
import '../helpers/dialog_helper.dart';
import '../models/surah_model.dart';
import '../sevices/local_storage_service.dart';
import '../widgets/search_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PdfController pdfController;
  late Surah currentSurah;
  late final TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    createPdfController();
    detectSurahOnInit();
    textEditingController = TextEditingController();
  }

  void createPdfController() {
    pdfController = PdfController(
      document: PdfDocument.openAsset('assets/quran-translation.pdf'),
      initialPage: LocalStorageService.pageNumber,
    );
  }

  void detectSurahOnInit() {
    final index = SurahConstants.listOfSurah.indexWhere((surah) {
      return pdfController.initialPage >= surah.startsFrom &&
          pdfController.initialPage < surah.ends;
    });
    currentSurah = SurahConstants.listOfSurah[index];
  }

  void detectSurah() {
    final index = SurahConstants.listOfSurah.indexWhere((surah) {
      return pdfController.page >= surah.startsFrom && pdfController.page < surah.ends;
    });
    currentSurah = SurahConstants.listOfSurah[index];
    setState(() {});
  }

  void goToPage(String value) {
    final page = int.parse(value);
    pdfController.jumpToPage(page);
    detectSurah();
    textEditingController.clear();
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
      leadingWidth: 200,
      actions: [
        allSurahButton,
        /*SearchBarWidget(
          onSubmitted: goToPage,
          pdfController: pdfController,
          controller: textEditingController,
        ),*/
      ],
    );
  }

  Widget get searchBar {
    return SearchBarWidget(
      onSubmitted: goToPage,
      pdfController: pdfController,
      controller: textEditingController,
    );
  }

  Widget get allSurahButton {
    return GestureDetector(
      onTap: () async {
        await DialogHelper.showSurahDialog(context, pdfController);
        LocalStorageService.pageNumber = pdfController.page;
        detectSurah();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'SURELER',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 10),
            Image.asset(
              'assets/images/quran.png',
              width: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget get body {
    return Column(
      children: [
        pdfSection,
        pageNavigationSection,
      ],
    );
  }

  Widget get pdfSection {
    return Expanded(
      child: IgnorePointer(
        ignoring: true,
        child: PdfView(
          controller: pdfController,
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
      ),
    );
  }

  Widget get pageNavigationSection {
    return Container(
      width: double.infinity,
      height: 60,
      color: Colors.teal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          fivePagesBackIconButton,
          previousIconButton,
          pageNumber,
          nextIconButton,
          fivePagesForwardIconButton,
        ],
      ),
    );
  }

  Widget get previousIconButton {
    return IconButton(
      onPressed: () async {
        await pdfController.previousPage(
          curve: Curves.ease,
          duration: const Duration(milliseconds: 100),
        );
        LocalStorageService.pageNumber = pdfController.page;
        detectSurah();
      },
      icon: const Icon(Icons.navigate_before),
      color: Colors.white,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
    );
  }

  Widget get nextIconButton {
    return IconButton(
      onPressed: () async {
        await pdfController.nextPage(
          curve: Curves.ease,
          duration: const Duration(milliseconds: 100),
        );
        LocalStorageService.pageNumber = pdfController.page;
        detectSurah();
      },
      icon: const Icon(Icons.navigate_next),
      color: Colors.white,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
    );
  }

  Widget get fivePagesBackIconButton {
    return GestureDetector(
      onTap: () {
        pdfController.jumpToPage(pdfController.page - 5);
        LocalStorageService.pageNumber = pdfController.page;
        detectSurah();
      },
      child: const Icon(
        Icons.keyboard_double_arrow_left,
        color: Colors.white,
      ),
    );
  }

  Widget get fivePagesForwardIconButton {
    return GestureDetector(
      onTap: () {
        pdfController.jumpToPage(pdfController.page + 5);
        LocalStorageService.pageNumber = pdfController.page;
        detectSurah();
      },
      child: const Icon(
        Icons.keyboard_double_arrow_right,
        color: Colors.white,
      ),
    );
  }

  Widget get pageNumber {
    return PdfPageNumber(
      controller: pdfController,
      builder: (_, loadingState, page, pagesCount) => Container(
        alignment: Alignment.center,
        child: Text(
          '$page/${pagesCount ?? 0}',
          style: const TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
