import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sports_trending/app/modules/home/views/home_view.dart';
import 'package:sports_trending/app/modules/language/controllers/language_controller.dart';
import 'package:sports_trending/app/modules/login/controllers/login_controller.dart';
import 'package:sports_trending/app/modules/login/views/login_view.dart';
import 'package:sports_trending/app/modules/onboarding/views/onboarding_view.dart';
import 'package:sports_trending/app/modules/search/views/videobyid.dart';
import 'package:sports_trending/app/modules/signup/views/signup_view.dart';
import 'package:sports_trending/core/shared_preference.dart';
import 'package:sports_trending/helper/life_cycle_controller.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/source/image_assets.dart';
import 'package:sports_trending/source/styles.dart';
import 'package:sports_trending/utils/screen_util.dart';
import 'package:sports_trending/widgets/common_svg_images.dart';

class SplashView extends StatefulWidget {
  var likk = "";
  SplashView(this.likk, {super.key});
  @override
  State<SplashView> createState() => _MyVideosState();
}

class _MyVideosState extends State<SplashView> {
  final LanguageController languageController = Get.put(LanguageController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToHomeScreen();
  }

  void navigateToHomeScreen() async {
    bool? isRemembered = SharedPref.getBool(PrefsKey.rememberMe);
    bool? isLoggedIn = SharedPref.getBool(PrefsKey.isLoggedIn);
    bool? hasSeenOnboarding = SharedPref.getBool(PrefsKey.onboarding);
    String? deeplinks = widget.likk;
    await languageController.loadLabels();
    String? isvideo = SharedPref.getString(PrefsKey.isVideoOpen);
    String? isSignuupOpen = SharedPref.getString(PrefsKey.isSignuupOpen);
    if (isvideo == "1") {
    } else {
      if (isSignuupOpen == "1") {
      } else {
        if (deeplinks.isNotEmpty) {
          var refcode = deeplinks.split("/");
          if (refcode[1] == "refer") {
            await SharedPref.setValue(PrefsKey.refercode, refcode[2]);

            if (isLoggedIn) {
              Get.offAll(() => HomeView());
            } else {
              Get.off(
                () => SignUpView(),
                transition: Transition.fade,
                duration: const Duration(milliseconds: 2000),
              );
            }
          } else {
            String? isvideo = SharedPref.getString(PrefsKey.isVideoOpen);
            if (isvideo == "1") {
            } else {
              if (refcode[2].isNotEmpty) {
                if (!Get.isRegistered<LoginController>()) {
                  Get.put(LoginController());
                }
                Get.offAll(() => VideoShortsPlayerScreen(refcode[2]));
              }
            }
          }
        } else {
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
        }
      }
    }

    // Future.delayed(Duration(seconds: 0), () {

    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorAssets.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonSvgImages(image: ImageAssets.splashImg),
          SizedBox(height: Constant.size20),
          Text(
            "Your ultimate sports hub: Explore reels, connect with fans, and elevate passion!",
            style: Styles.textStyleBlackNormal,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Constant.size30),
          //CommonSvgImages(image: ImageAssets.loaderImg),
          Lottie.asset(
            'assets/animation.json',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(height: Constant.size50),
          Obx(
            () => Align(
              alignment: Alignment.bottomCenter,
              child:
                  languageController.isLoading.value
                      ? Container(
                        alignment: Alignment.center,

                        child: CircularProgressIndicator(
                          // valueColor: AlwaysStoppedAnimation<Color>(
                          color: ColorAssets.themeColorOrange,
                          //   ),
                        ),
                      )
                      : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}

