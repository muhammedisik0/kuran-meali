import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/string_constants.dart';
import '../services/local_storage_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_icon_button.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void onPressedPageDirectionButton() {
    LocalStorageService.setScrollDirection();
    setState(() {});
  }

  void onPressedShareAppButton() => Share.share(StringConstants.playStoreUrl);

  void onPressedRateAppButton() {
    LaunchReview.launch(
      androidAppId: StringConstants.packageName,
    );
  }

  void onPressedContactUsButton() {
    final String email = Uri.encodeComponent(StringConstants.contactEmail);
    final String subject = Uri.encodeComponent('');
    final String body = Uri.encodeComponent('');
    Uri url = Uri.parse('mailto:$email?subject=$subject&body=$body');
    launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: body,
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.teal,
      title: const Text('Ayarlar'),
      leading: CustomIconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back),
      ),
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
              pageDirection,
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

  Widget get pageDirection {
    return CustomButton(
      onPressed: onPressedPageDirectionButton,
      icon: const Icon(Icons.filter_list),
      text: 'Sayfa Akışı',
      child: Text(
        LocalStorageService.scrollDirection ? 'Dikey' : 'Yatay',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget get shareAppSection {
    return CustomButton(
      onPressed: onPressedShareAppButton,
      icon: const Icon(Icons.share_outlined),
      text: 'Uygulamayı Paylaş',
    );
  }

  Widget get rateAppSection {
    return CustomButton(
        onPressed: onPressedRateAppButton,
        icon: const Icon(Icons.star_rate_outlined),
        text: 'Uygulamayı Değerlendir');
  }

  Widget get contactUsSection {
    return CustomButton(
        onPressed: onPressedContactUsButton,
        icon: const Icon(Icons.mail_outlined),
        text: 'İletişime Geçin');
  }

  Widget get versionNumber {
    return const Text(
      'Versiyon 1.1.0',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
    );
  }
}
