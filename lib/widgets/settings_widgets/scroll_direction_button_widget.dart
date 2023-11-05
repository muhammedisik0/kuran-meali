import 'package:flutter/material.dart';

import '../../constants/text_constants.dart';
import '../../services/storage_service.dart';
import '../common_widgets/settings_item_button_widget.dart';

class ScrollDirectionButton extends StatefulWidget {
  const ScrollDirectionButton({super.key});

  @override
  State<ScrollDirectionButton> createState() => _ScrollDirectionButtonState();
}

class _ScrollDirectionButtonState extends State<ScrollDirectionButton> {
  late bool isVertical;

  String get scrollDirection =>
      isVertical ? TextConstants.vertical : TextConstants.horizontal;

  @override
  void initState() {
    super.initState();
    isVertical = StorageService.scrollDirection;
  }

  void onPressed() {
    setState(() => isVertical = !isVertical);
    StorageService.setScrollDirection();
  }

  @override
  Widget build(BuildContext context) {
    return SettingsItemButton(
      onPressed: onPressed,
      icon: const Icon(Icons.filter_list_outlined),
      text: TextConstants.scrollDirection,
      child: Text(
        scrollDirection,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),
    );
  }
}
