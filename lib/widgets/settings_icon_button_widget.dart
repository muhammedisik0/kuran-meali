import 'package:flutter/material.dart';
import 'package:kuran_meali/services/storage_service.dart';

import '../constants/route_constants.dart';
import 'custom_icon_button_widget.dart';

class SettingsIconButton extends StatelessWidget {
  const SettingsIconButton({super.key, required this.callback});

  final VoidCallback callback;

  Future<void> onPressed(BuildContext context) async {
    final tempIsVertical = StorageService.scrollDirection;
    await Navigator.pushNamed(context, RouteConstants.settings);
    final isVertical = StorageService.scrollDirection;
    if (tempIsVertical != isVertical) callback();
  }

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onPressed: () => onPressed(context),
      icon: const Icon(Icons.settings),
    );
  }
}
