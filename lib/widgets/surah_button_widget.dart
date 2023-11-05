import 'package:flutter/material.dart';
import 'package:kuran_meali/models/surah_model.dart';

import '../constants/color_constants.dart';

class SurahButton extends StatelessWidget {
  const SurahButton({
    super.key,
    required this.onPressed,
    required this.surah,
  });

  final VoidCallback onPressed;
  final Surah surah;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
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
                '${surah.number}',
                style: const TextStyle(
                  color: ColorConstants.teal,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              surah.name,
              style: const TextStyle(
                fontSize: 16,
                color: ColorConstants.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
