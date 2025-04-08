import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sports_trending/app/app_pages/app_pages.dart';
import 'package:sports_trending/app/modules/login/views/login_view.dart';
import 'package:sports_trending/core/shared_preference.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  final pageController = PageController();

  void changePage(int index) {
    currentPage.value = index;

    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  void nextPage() {
    if (currentPage.value < 2) {
      changePage(currentPage.value + 1);
    } else {
      SharedPref.setValue(PrefsKey.onboarding, true);
      Get.off(LoginView());
    }
  }

  onTapSkip() {
    Get.offAllNamed(AppPages.login);
  }
}
