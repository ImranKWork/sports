import 'package:app_links/app_links.dart' as prix;
import 'package:get/get.dart';
import 'package:sports_trending/app/modules/home/views/home_view.dart';
import 'package:sports_trending/app/modules/language/controllers/language_controller.dart';
import 'package:sports_trending/app/modules/login/views/login_view.dart';
import 'package:sports_trending/core/shared_preference.dart';

import '../../onboarding/views/onboarding_view.dart';

class SplashController extends GetxController {
  final languageController = Get.find<LanguageController>();

  @override
  void onReady() {
    super.onReady();
    navigateToHomeScreen();
      _initDeepLinks();
  }
 Future<void> _initDeepLinks() async {
    // Handle initial link (when app is launched by a link)
    try {
      final uri = await _appLinks.getInitialLink();
      if (uri != null) {
        _handleLink(uri);
      }
    } catch (e) {
      print('Initial link error: $e');
    }

    // Handle background link (when app is already open)
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleLink(uri);
      }
    });
  }

  void _handleLink(Uri uri) {
    print('Received link: $uri');
    // Handle navigation based on URI path
    // if (uri.path == '/profile') {
    //   Navigator.pushNamed(context, '/profile');
    // }
    // Add more routes if needed
  }

   final prix.AppLinks _appLinks = prix.AppLinks();

  void navigateToHomeScreen() async {
    bool? isRemembered = SharedPref.getBool(PrefsKey.rememberMe);
    bool? isLoggedIn = SharedPref.getBool(PrefsKey.isLoggedIn);
    bool? hasSeenOnboarding = SharedPref.getBool(PrefsKey.onboarding);
    await languageController.loadLabels();
    // Future.delayed(Duration(seconds: 0), () {
    if (isLoggedIn) {
      Get.offAll(() => HomeView());
    } else {
      if (hasSeenOnboarding) {
        Get.off(
          () => LoginView(),
          transition: Transition.fade,
          duration: const Duration(milliseconds: 2000),
        );
      } else {
        Get.off(
          () => OnboardingView(),
          // transition: Transition.fade,
          duration: const Duration(milliseconds: 1000),
        );
      }
    }
    // });
  }
}
