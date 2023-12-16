import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kuran_meali/view_models/home_view_model.dart';
import 'package:kuran_meali/view_models/notes_view_model.dart';
import 'package:provider/provider.dart';

import 'constants/route_constants.dart';
import 'constants/storage_key_constants.dart';
import 'views/home_view.dart';
import 'views/notes_view.dart';
import 'views/settings_view.dart';
import 'views/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(StorageKeyConstants.quran);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(
            create: (context) => HomeViewModel()),
        ChangeNotifierProvider<NotesViewModel>(
            create: (context) => NotesViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RouteConstants.initialRoute,
        routes: {
          RouteConstants.initialRoute: (context) => const SplashView(),
          RouteConstants.home: (context) => const HomeView(),
          RouteConstants.settings: (context) => const SettingsView(),
          RouteConstants.notes: (context) => const NotesView(),
        },
      ),
    );
  }
}
