import 'package:flutter/material.dart';
import 'package:kuran_meali/constants/color_constants.dart';
import 'package:kuran_meali/constants/path_constants.dart';
import 'package:kuran_meali/constants/text_constants.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHomeScreen();
  }

  Future<void> navigateToHomeScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstants.teal,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    TextConstants.shortExplanatory,
                    style: TextStyle(
                      color: ColorConstants.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    TextConstants.quranKareemMeaning,
                    style: TextStyle(
                      color: ColorConstants.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    TextConstants.mahmutKisa,
                    style: TextStyle(
                      color: ColorConstants.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 80,
              child: Image.asset(
                PathConstants.icQuran,
                width: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
