import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import '../constants/surah_constants.dart';

class DialogHelper {
  static Future<void> showSurahDialog(
    BuildContext context,
    PdfController pdfController,
  ) async {
    final listOfSurah = SurahConstants.listOfSurah;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
          title: const Center(child: Text('Sureler')),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: listOfSurah.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    final selectedSurah = listOfSurah[index];
                    pdfController.jumpToPage(selectedSurah.startsFrom);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.teal,
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.white,
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: Colors.teal,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          listOfSurah[index].name,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 5);
              },
            ),
          ),
        );
      },
    );
  }
}
