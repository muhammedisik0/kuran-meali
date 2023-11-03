import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kuran_meali/constants/color_constants.dart';
import 'package:kuran_meali/constants/text_constants.dart';

import '../models/note_model.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const NoteCard({
    super.key,
    required this.note,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(width: 4, color: ColorConstants.teal)),
      ),
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: title),
                  moreButton,
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: content,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get title {
    return AutoSizeText(
      note.title,
      maxLines: 1,
      minFontSize: 14,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget get content {
    return Text(
      note.content,
      style: const TextStyle(fontSize: 14),
    );
  }

  Widget get moreButton {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'edit') {
          onEdit();
        } else if (value == 'delete') {
          onDelete();
        }
      },
      icon: const Icon(Icons.more_vert, size: 20),
      splashRadius: null,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'edit',
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(Icons.edit, color: ColorConstants.black, size: 20),
              SizedBox(width: 8),
              Text(TextConstants.edit),
            ],
          ),
        ),
        const PopupMenuItem<String>(
          value: 'delete',
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(Icons.delete, color: ColorConstants.black, size: 20),
              SizedBox(width: 8),
              Text(TextConstants.delete),
            ],
          ),
        ),
      ],
    );
  }
}
