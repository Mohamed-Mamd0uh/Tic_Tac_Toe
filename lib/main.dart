import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/localization/local_controller.dart';
import 'package:tic_tac_toe/localization/locali.dart';
import 'package:tic_tac_toe/localization/setting_service.dart';
import 'package:tic_tac_toe/screens/home_screen.dart';

import 'theme/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  await Get.putAsync(() => SettingService().init());
  Get.put(LocalController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final LocalController localController = Get.find<LocalController>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: localController.initLocal,
      translations: TranslationService(),
      title: 'Tic Tac Toe',
      theme: ThemeData(
        scaffoldBackgroundColor: primaryColor,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
