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
  }

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
