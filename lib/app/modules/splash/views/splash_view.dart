import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sports_trending/app/modules/language/controllers/language_controller.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/source/image_assets.dart';
import 'package:sports_trending/source/styles.dart';
import 'package:sports_trending/utils/screen_util.dart';
import 'package:sports_trending/widgets/common_svg_images.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  SplashView({super.key});

  final LanguageController languageController = Get.put(LanguageController());

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
