import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';
import '../../constants/path_constants.dart';
import '../../constants/route_constants.dart';
import '../../constants/text_constants.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    navigateToHomeScreen();
  }

  Future<void> navigateToHomeScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, RouteConstants.home);
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    TextConstants.quranKareemMeaning,
                    style: TextStyle(
                      color: ColorConstants.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ColorConstants.white,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: const Text(
                      TextConstants.mahmutKisa,
                      style: TextStyle(
                        color: ColorConstants.teal,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 60,
              child: Image.asset(PathConstants.icApp, width: 128),
            ),
          ],
        ),
      ),
    );
  }
}
