import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sports_trending/app/modules/home/views/home_view.dart';
import 'package:sports_trending/app/modules/login/controllers/login_controller.dart';
import 'package:sports_trending/app/modules/login/views/login_view.dart';
import 'package:sports_trending/app/modules/onboarding/views/onboarding_view.dart';
import 'package:sports_trending/app/modules/search/views/videobyid.dart';
import 'package:sports_trending/app/modules/signup/views/signup_view.dart';
import 'package:sports_trending/app/modules/splash/views/splash_view.dart';
import 'core/shared_preference.dart';
import 'helper/life_cycle_controller.dart';
import 'service/navigation_service.dart';
import 'app/app_pages/app_pages.dart';
import 'app/modules/language/controllers/language_controller.dart';
import 'source/color_assets.dart';
import 'source/string_assets.dart';

final AppLinks _appLinks = AppLinks();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ─── Your usual init ──────────────────────────────────────────────
  await Hive.initFlutter();
  await Hive.openBox('video_cache');
  await SharedPref.init();
  await Firebase.initializeApp();
  await GetStorage.init();
  Get.put(LifeCycleController());
  Get.put(LanguageController());
  // ──────────────────────────────────────────────────────────────────

  // 1️⃣ Get the “initial” incoming deep‐link (cold start)
  Uri? initialUri;
  try {
    initialUri = await _appLinks.getInitialLink();
  } on PlatformException {
    initialUri = null;
  }

  // 2️⃣ Then run your one-and-only app, passing that URI along
  runApp(MyApp(initialUri: initialUri));
}

class MyApp extends StatefulWidget {
  final Uri? initialUri;
  const MyApp({Key? key, this.initialUri}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription<Uri?>? _sub;
  @override
  void initState() {
    super.initState();

    // If we got a link at cold-start, navigate once after first frame:
    if (widget.initialUri != null) {
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   NavigationService.navigatorKey.currentState?.pushNamed(AppPages.splash);
      // });
    }
    deeplinkhandle();
    // Listen for any future incoming links and push them
  }

  var links = "";
  deeplinkhandle() async {
    await SharedPref.setValue(PrefsKey.isVideoOpen, "");
    await SharedPref.setValue(PrefsKey.isSignuupOpen, "");

    _sub = _appLinks.uriLinkStream.listen(
      (uri) async {
        if (uri != null) {
          links = uri.path.toString();
          final LanguageController languageController = Get.put(
            LanguageController(),
          );

          await languageController.loadLabels();
          if (uri.path.isNotEmpty) {
            var refcode = uri.path.split("/");
            if (refcode[1] == "refer") {
              await SharedPref.setValue(PrefsKey.refercode, refcode[2]);
              bool? isLoggedIn = SharedPref.getBool(PrefsKey.isLoggedIn);

              if (isLoggedIn) {
                Get.offAll(() => HomeView());
              } else {
                await SharedPref.setValue(PrefsKey.isSignuupOpen, "1");

                Get.off(
                  () => SignUpView(),
                  transition: Transition.fade,
                  duration: const Duration(milliseconds: 2000),
                );
              }
            } else {
              bool? isLoggedIn = SharedPref.getBool(PrefsKey.isLoggedIn);
              bool? hasSeenOnboarding = SharedPref.getBool(PrefsKey.onboarding);

              if (!Get.isRegistered<LoginController>()) {
                Get.put(LoginController());
              }
              Get.offAll(() => VideoShortsPlayerScreen(refcode[2]));
            }
          }

          //NavigationService.navigatorKey.currentState?.pushNamed(uri.path);
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   Get.snackbar(
          //     "Imran",
          //     "blaa. blaa...",
          //     snackPosition: SnackPosition.BOTTOM,
          //     backgroundColor: ColorAssets.error,
          //     colorText: Colors.white,
          //   );
          // });
        }
      },
      onError: (_) {
        // ignore malformed links
      },
    );
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: StringAssets.app_name,
      home: SplashView(links),
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerKey,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorAssets.themeColorOrange,
        ),
      ),
    );
  }
}

