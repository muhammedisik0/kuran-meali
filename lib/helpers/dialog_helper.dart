import 'package:flutter/material.dart';
import 'package:kuran_meali/constants/text_constants.dart';
import 'package:kuran_meali/widgets/action_button_widget.dart';
import '../constants/color_constants.dart';
import '../models/note_model.dart';
import '../widgets/custom_textfield_widget.dart';
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
          insetPadding:
              const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
          title: const Center(child: Text(TextConstants.surahs)),
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
                      color: ColorConstants.teal,
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: ColorConstants.white,
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: ColorConstants.teal,
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
                            color: ColorConstants.white,
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

  static Future showAddNoteDialog(BuildContext context,
      {bool isEdit = false, Note? note}) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    if (isEdit) {
      titleController.text = note!.title;
      contentController.text = note.content;
    }

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title:
              Text(isEdit ? TextConstants.editNote : TextConstants.createNote),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: titleController,
                autoFocus: true,
                labelText: TextConstants.title,
                inputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: contentController,
                labelText: TextConstants.content,
                maxLines: 8,
              ),
            ],
          ),
          actions: [
            ActionButton(
              onPressed: () {
                Navigator.of(context).pop([false]);
              },
              foregroundColor: ColorConstants.black,
              backgroundColor: ColorConstants.transparent,
              text: TextConstants.cancel,
            ),
            ActionButton(
              onPressed: () {
                String title = titleController.text.trim();
                String content = contentController.text.trim();
                if (title.isEmpty) title = '...';
                if (content.isEmpty) content = '...';
                final note = Note(title: title, content: content);
                Navigator.of(context).pop([true, note]);
              },
              foregroundColor: ColorConstants.white,
              backgroundColor: ColorConstants.teal,
              text: TextConstants.save,
            ),
          ],
        );
      },
    );
  }

  static Future showConfirmationDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text(TextConstants.deleteNote),
          content: const Text(TextConstants.areYouSureYouWantToDeleteTheNote),
          actions: [
            ActionButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              foregroundColor: ColorConstants.black,
              backgroundColor: ColorConstants.transparent,
              text: TextConstants.cancel,
            ),
            ActionButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              foregroundColor: ColorConstants.white,
              backgroundColor: ColorConstants.red,
              text: TextConstants.delete,
            ),
          ],
        );
      },
    );
  }
}
