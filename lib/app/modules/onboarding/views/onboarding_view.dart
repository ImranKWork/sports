import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_trending/app/modules/language/controllers/language_controller.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/source/image_assets.dart';
import 'package:sports_trending/source/styles.dart' show Styles;
import 'package:sports_trending/utils/screen_util.dart';
import 'package:sports_trending/widgets/common_button.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  OnboardingView({super.key});

  final OnboardingController onboardingController = Get.put(
    OnboardingController(),
  );
  final LanguageController languageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () =>
            languageController.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : Stack(
                  children: [
                    PageView(
                      controller: onboardingController.pageController,
                      onPageChanged: (index) {
                        onboardingController.changePage(index);
                      },
                      children: [
                        OnboardingPage(
                          imagePath: ImageAssets.onboardingImg1,
                          title: languageController.getLabel(
                            "onboarding_sub_1",
                          ),
                          description: languageController.getLabel(
                            "onboarding_main_1",
                          ),
                        ),
                        OnboardingPage(
                          imagePath: ImageAssets.onboardingImg2,
                          title: languageController.getLabel("onbording_sub_2"),
                          description: languageController.getLabel(
                            "onbording_main_2",
                          ),
                        ),
                        OnboardingPage(
                          imagePath: ImageAssets.onboardingImg3,
                          title: languageController.getLabel(
                            "onbording_main_3",
                          ),
                          description: languageController.getLabel(
                            "onbording_main_3",
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: Constant.size40,
                      right: Constant.size20,
                      child: TextButton(
                        onPressed: () {
                          languageController.onSkipPressed();
                        },
                        child: Text(
                          languageController.getLabel("skip"),
                          style: Styles.textStyleBlackNormal,
                        ),
                      ),
                    ),
                    Obx(
                      () => Positioned(
                        bottom: Constant.size10,
                        left: 10,
                        right: 10,
                        child: Container(
                          margin: EdgeInsets.all(Constant.size10),
                          width: Get.width,
                          child: CommonButton(
                            label:
                                controller.currentPage.value == 0 ||
                                        controller.currentPage.value == 1
                                    ? languageController.getLabel("next_btn")
                                    : languageController.getLabel(
                                      "get_started",
                                    ),
                            onClick: () {
                              controller.nextPage();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  final OnboardingController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          imagePath,
          width: Get.width,
          height: Get.height,
          fit: BoxFit.cover,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: Styles.textStyleWhiteSemiBold.copyWith(
                fontSize: FontSize.s18,
              ),
              textAlign: TextAlign.center,
            ).paddingOnly(
              left: Constant.size15,
              right: Constant.size15,
              bottom: Constant.size10,
            ),
            Text(
              description,
              style: Styles.textStyleWhiteNormal,
              textAlign: TextAlign.center,
            ).paddingOnly(
              left: Constant.size25,
              right: Constant.size25,
              bottom: Constant.size30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) => buildDot(index)),
            ),
            SizedBox(height: Constant.size100),
          ],
        ),
      ],
    );
  }

  Widget buildDot(int index) {
    return Obx(() {
      return Container(
        height: Constant.size10,
        width:
            controller.currentPage.value == index
                ? Constant.size40
                : Constant.size10,
        margin: EdgeInsets.only(right: Constant.size5),
        decoration: BoxDecoration(
          color:
              controller.currentPage.value == index
                  ? ColorAssets.themeColorOrange
                  : Colors.grey,
          borderRadius: BorderRadius.circular(Constant.size5),
        ),
      );
    });
  }
}
