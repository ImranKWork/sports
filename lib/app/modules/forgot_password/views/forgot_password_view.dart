import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_trending/app/modules/forgot_password/controllers/forgot_password_controller.dart'
    show ForgotPasswordController;
import 'package:sports_trending/app/modules/language/controllers/language_controller.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/source/image_assets.dart';
import 'package:sports_trending/source/styles.dart';
import 'package:sports_trending/utils/screen_util.dart';
import 'package:sports_trending/widgets/common_button.dart';
import 'package:sports_trending/widgets/common_svg_images.dart';
import 'package:sports_trending/widgets/custom_text_form_field.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  final ForgotPasswordController controller = Get.put(
    ForgotPasswordController(),
  );

  final LanguageController languageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.1),

          // Logo
          Center(
            child: Stack(
              children: [
                CommonSvgImages(image: ImageAssets.ellipse),
                Positioned(
                  top: Constant.size35,
                  left: Constant.size35,
                  child: CommonSvgImages(image: ImageAssets.message),
                ),
              ],
            ),
          ),
          SizedBox(height: Constant.size10),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: Constant.size10),
            child: Text(
              languageController.getLabel("forgot_password_tag_line"),
              textAlign: TextAlign.center,
              style: Styles.textStyleBlackMedium.copyWith(
                fontSize: FontSize.s18,
              ),
            ),
          ),

          SizedBox(height: Constant.size30),

          // reset password form
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: Get.height,
                padding: EdgeInsets.all(Constant.size20),
                decoration: BoxDecoration(
                  color: ColorAssets.purple,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Constant.size20),
                    topRight: Radius.circular(Constant.size20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      languageController.getLabel("lost_password"),
                      style: Styles.textStyleWhiteMedium.copyWith(
                        fontSize: FontSize.s18,
                      ),
                    ),
                    SizedBox(height: Constant.size20),

                    Text(
                      languageController.getLabel("email_header"),
                      style: Styles.textStyleWhiteNormal.copyWith(
                        color: ColorAssets.white,

                        fontSize: FontSize.s13,
                      ),
                    ),
                    SizedBox(height: Constant.size5),
                    CustomTextFormField(
                      input: TextInputAction.next,
                      textInputType: TextInputType.emailAddress,
                      controller: controller.emailController,
                      placeHolder: languageController.getLabel("email_empty"),
                      disableFloatingLabel: true,
                    ),

                    SizedBox(height: Constant.size25),

                    Obx(
                      () =>
                          controller.isLoading.value
                              ? Container(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    ColorAssets.themeColorOrange,
                                  ),
                                ),
                              )
                              : CommonButton(
                                label: languageController.getLabel(
                                  "reset_password",
                                ),
                                onClick: () {
                                  controller.reset();
                                },
                              ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
