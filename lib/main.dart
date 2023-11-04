import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kuran_meali/constants/storage_key_constants.dart';
import 'package:kuran_meali/screens/home_screen.dart';
import 'package:kuran_meali/screens/my_notes_screen.dart';
import 'package:kuran_meali/screens/settings_screen.dart';
import 'constants/route_constants.dart';
import 'utils/globals.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(StorageKeyConstants.quran);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: RouteConstants.initialRoute,
      routes: {
        RouteConstants.initialRoute: (context) => const SplashScreen(),
        RouteConstants.home: (context) => const HomeScreen(),
        RouteConstants.settings: (context) => const SettingsScreen(),
        RouteConstants.myNotes: (context) => const MyNotesScreen(),
      },
    );
  }
}
