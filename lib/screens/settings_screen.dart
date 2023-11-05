import 'package:flutter/material.dart';
import 'package:kuran_meali/widgets/scroll_direction_button_widget.dart';
import '../constants/text_constants.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/color_constants.dart';
import '../constants/app_constants.dart';
import '../widgets/settings_item_button_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void onShareAppPressed() => Share.share(AppConstants.playStoreUrl);

  void onRateAppPressed() =>
      LaunchReview.launch(androidAppId: AppConstants.packageName);

  void onContactUsPressed() {
    final String email = Uri.encodeComponent(AppConstants.contactEmail);
    final String subject = Uri.encodeComponent('');
    final String body = Uri.encodeComponent('');
    Uri url = Uri.parse('mailto:$email?subject=$subject&body=$body');
    launchUrl(url);
  }

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const ScrollDirectionButton(),
              shareAppSection,
              rateAppSection,
              contactUsSection,
            ],
          ),
          versionNumber,
        ],
      ),
    );
  }

  Widget get shareAppSection {
    return SettingsItemButton(
      onPressed: onShareAppPressed,
      icon: const Icon(Icons.share_outlined),
      text: TextConstants.shareApp,
    );
  }

  Widget get rateAppSection {
    return SettingsItemButton(
      onPressed: onRateAppPressed,
      icon: const Icon(Icons.star_rate_outlined),
      text: TextConstants.rateApp,
    );
  }

  Widget get contactUsSection {
    return SettingsItemButton(
      onPressed: onContactUsPressed,
      icon: const Icon(Icons.mail_outlined),
      text: TextConstants.contactUs,
    );
  }

  Widget get versionNumber {
    return const Text(
      '${TextConstants.version} 1.1.0',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: ColorConstants.mediumGray,
      ),
    );
  }
}
