import 'package:flutter/material.dart';

import '../../constants/route_constants.dart';
import '../base_widgets/custom_icon_button_widget.dart';

class NotesIconButton extends StatelessWidget {
  const NotesIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onPressed: () => Navigator.pushNamed(context, RouteConstants.notes),
      icon: const Icon(Icons.my_library_books),
    );
  }
}
