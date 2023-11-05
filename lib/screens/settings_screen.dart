import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../constants/text_constants.dart';
import '../widgets/settings_widgets/contact_us_button_widget.dart';
import '../widgets/settings_widgets/rate_app_button_widget.dart';
import '../widgets/settings_widgets/scroll_direction_button_widget.dart';
import '../widgets/settings_widgets/share_app_button_widget.dart';
import '../widgets/settings_widgets/version_number_text_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }

  AppBar get appBar {
    return AppBar(
      backgroundColor: ColorConstants.teal,
      title: const Text(TextConstants.settings),
    );
  }

  Widget get body {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              ScrollDirectionButton(),
              ShareAppButton(),
              RateAppButton(),
              ContactUsButton(),
            ],
          ),
          VersionNumber(),
        ],
      ),
    );
  }
}
