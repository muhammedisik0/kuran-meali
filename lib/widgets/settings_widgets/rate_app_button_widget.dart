import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';

import '../../constants/app_constants.dart';
import '../../constants/text_constants.dart';
import '../common_widgets/settings_item_button_widget.dart';

class RateAppButton extends StatelessWidget {
  const RateAppButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsItemButton(
      onPressed: () =>
          LaunchReview.launch(androidAppId: AppConstants.packageName),
      icon: const Icon(Icons.star_rate_outlined),
      text: TextConstants.rateApp,
    );
  }
}
