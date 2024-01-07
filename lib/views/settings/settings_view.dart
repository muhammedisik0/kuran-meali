import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share_plus/share_plus.dart';

import '../../constants/app_constants.dart';
import '../../constants/color_constants.dart';
import '../../constants/text_constants.dart';
import 'widgets/settings_item_button_widget.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _IAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ShareAppButton(),
                RateAppButton(),
                ContactUsButton(),
              ],
            ),
            VersionNumber(),
          ],
        ),
      ),
    );
  }
}

class _IAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _IAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.teal,
      title: const Text(TextConstants.settings),
    );
  }
}

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

class ContactUsButton extends StatelessWidget {
  const ContactUsButton({super.key});

  void onContactUsPressed() {
    final String email = Uri.encodeComponent(AppConstants.contactEmail);
    final String subject = Uri.encodeComponent('Geri Bildirim');
    final String body = Uri.encodeComponent('');
    Uri url = Uri.parse('mailto:$email?subject=$subject&body=$body');
    launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return SettingsItemButton(
      onPressed: onContactUsPressed,
      icon: const Icon(Icons.mail_outlined),
      text: TextConstants.contactUs,
    );
  }
}

class VersionNumber extends StatelessWidget {
  const VersionNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '${TextConstants.version} ${AppConstants.appVersion}',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: ColorConstants.mediumGray,
      ),
    );
  }
}
