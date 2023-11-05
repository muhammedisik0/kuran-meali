import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_constants.dart';
import '../../constants/text_constants.dart';
import '../common_widgets/settings_item_button_widget.dart';

class ContactUsButton extends StatelessWidget {
  const ContactUsButton({super.key});

  void onContactUsPressed() {
    final String email = Uri.encodeComponent(AppConstants.contactEmail);
    final String subject = Uri.encodeComponent('');
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
