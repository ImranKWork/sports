import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_trending/app/modules/home/views/home_view.dart'; // ✅ Add this if not imported
import 'package:sports_trending/app/modules/language/controllers/language_controller.dart';
import 'package:sports_trending/core/shared_preference.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/source/image_assets.dart';
import 'package:sports_trending/source/styles.dart';
import 'package:sports_trending/utils/screen_util.dart';
import 'package:sports_trending/widgets/common_button.dart';

class LanguageView extends StatelessWidget {
  LanguageView({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.accessToken,
    required this.fromSignup,
  });

  final String firstName, lastName, email, accessToken;
  final bool fromSignup;

  final LanguageController controller = Get.put(LanguageController());

  final List<Map<String, String>> languages = [
    {"name": "English (US)", "flag": ImageAssets.english, "code": "en"},
    {"name": "Spanish", "flag": ImageAssets.spanish, "code": "es"},
    {"name": "French", "flag": ImageAssets.french, "code": "fr"},
  ];

  @override
  Widget build(BuildContext context) {
    String lang = SharedPref.getString(PrefsKey.language, "");
    if (lang.isNotEmpty) {
      controller.selectedLanguageCode.value = lang;
    }
    return Scaffold(
      backgroundColor: ColorAssets.white,
      body: Padding(
        padding: EdgeInsets.all(Constant.size20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Constant.size20),
            SizedBox(height: Constant.size30),
            Text(
              controller.getLabel("lang_header"),
              style: Styles.textStyleBlackMedium.copyWith(
                fontSize: FontSize.s18,
              ),
            ),
            SizedBox(height: Constant.size5),
            Text(
              controller.getLabel("lang_sub_header"),
              style: Styles.textStyleBlackMedium.copyWith(
                fontSize: FontSize.s12,
                color: ColorAssets.darkGrey,
              ),
            ),
            SizedBox(height: Constant.size20),
            /// Language selection list
            Column(
              children:
                  languages.map((language) {
                    return Obx(
                      () => GestureDetector(
                        onTap:
                            () => controller.selectLanguage(
                              language["name"] ?? "",
                              language["code"] ?? "",
                            ),
                        child: Container(
                          margin: EdgeInsets.only(bottom: Constant.size10),
                          padding: EdgeInsets.all(Constant.size12),
                          decoration: BoxDecoration(
                            color:
                                controller.selectedLanguageCode.value ==
                                        language["code"]
                                    ? Colors.orange.shade100
                                    : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(
                              Constant.size12,
                            ),
                            border: Border.all(
                              color:
                                  controller.selectedLanguageCode.value ==
                                          language["code"]
                                      ? ColorAssets.themeColorOrange
                                      : Colors.transparent,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                language["flag"]!,
                                height: Constant.size30,
                                width: Constant.size30,
                              ),
                              SizedBox(width: Constant.size10),
                              Expanded(
                                child: Text(
                                  language["name"]!,
                                  style: Styles.textStyleBlackMedium.copyWith(
                                    fontSize: FontSize.s12,
                                    color:
                                        controller.selectedLanguage.value ==
                                                language["name"]
                                            ? ColorAssets.purple
                                            : ColorAssets.darkGrey,
                                  ),
                                ),
                              ),
                              Icon(
                                controller.selectedLanguageCode.value ==
                                        language["code"]
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color:
                                    controller.selectedLanguageCode.value ==
                                            language["code"]
                                        ? ColorAssets.themeColorOrange
                                        : ColorAssets.darkGrey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),

            SizedBox(height: Constant.size10),

            Obx(
              () =>
                  controller.isLoading.value
                      ? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            ColorAssets.themeColorOrange,
                          ),
                        ),
                      )
                      : CommonButton(
                        label: controller.getLabel("done"),
                        onClick: () {
                          if (fromSignup) {
                            controller.onDonePressed(
                              firstName,
                              lastName,
                              email,
                              accessToken,
                            );
                          } else {
                            controller.onDonePressed2(context);
                          }

                          //if (controller.selectedLanguage.value.isEmpty) {
                          //   Get.snackbar("Error", "Please select a language");
                          //   return;
                          // }

                          //controller.isLoading.value = true;
                          // Future.delayed(const Duration(seconds: 1), () {
                          //   controller.isLoading.value = false;

                          //   if (fromSignup) {
                          //     Get.offAll(() => HomeView());
                          //   } else {
                          //     Get.back();
                          //   }
                          // });
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
