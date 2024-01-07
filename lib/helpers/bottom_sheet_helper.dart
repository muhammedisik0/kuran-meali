import 'package:flutter/material.dart';

import '../constants/surah_constants.dart';
import '../constants/text_constants.dart';
import '../models/surah_model.dart';
import '../widgets/common_widgets/surah_button_widget.dart';

class BottomSheetHelper {
  static Future showSurahsBottomSheet(BuildContext context) {
    final List<Surah> listOfSurahs = SurahConstants.listOfSurahs;

    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(TextConstants.surahs,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemCount: listOfSurahs.length,
                  itemBuilder: (context, index) {
                    final surah = listOfSurahs[index];
                    return SurahButton(
                      onPressed: () {
                        final selectedSurah = listOfSurahs[index];
                        Navigator.of(context).pop(selectedSurah);
                      },
                      surah: surah,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 5),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
