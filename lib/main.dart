import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sports_trending/app/app_pages/app_pages.dart';
import 'package:sports_trending/app/modules/language/controllers/language_controller.dart';
import 'package:sports_trending/service/navigation_service.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/source/string_assets.dart';

import 'core/shared_preference.dart';
import 'helper/life_cycle_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  await Firebase.initializeApp();
  Get.put(LifeCycleController());
  Get.put(LanguageController());
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      title: StringAssets.app_name,
      initialRoute: AppPages.splash,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorAssets.themeColorOrange,
        ),
      ),
    ),
  );
}
