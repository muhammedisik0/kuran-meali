import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'constants/route_constants.dart';
import 'constants/storage_key_constants.dart';
import 'screens/home_screen.dart';
import 'screens/notes_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/splash_screen.dart';
import 'utils/globals.dart';

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
        RouteConstants.notes: (context) => const NotesScreen(),
      },
    );
  }
}
