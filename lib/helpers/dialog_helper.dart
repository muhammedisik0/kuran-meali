import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import '../constants/surah_constants.dart';

class DialogHelper {
  static Future<void> showSurahDialog(BuildContext context, PdfController pdfController) async {
    final listOfSurah = SurahConstants.listOfSurah;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
          //title: const Center(child: Text('Sureler')),
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
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.teal,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: Colors.teal,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          listOfSurah[index].name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
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
