import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../constants/app_constants.dart';
import '../../constants/text_constants.dart';
import '../common_widgets/settings_item_button_widget.dart';

class ShareAppButton extends StatelessWidget {
  const ShareAppButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsItemButton(
      onPressed: () => Share.share(AppConstants.playStoreUrl),
      icon: const Icon(Icons.share_outlined),
      text: TextConstants.shareApp,
    );
  }
}
