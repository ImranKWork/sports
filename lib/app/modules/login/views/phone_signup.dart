import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_trending/app/modules/language/controllers/language_controller.dart';
import 'package:sports_trending/app/modules/login/controllers/phone_signup_controller.dart';
import 'package:sports_trending/app/modules/login/views/login_view.dart';
import 'package:sports_trending/app/modules/signup/controllers/signup_controller.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/source/image_assets.dart';
import 'package:sports_trending/source/styles.dart';
import 'package:sports_trending/utils/screen_util.dart';
import 'package:sports_trending/widgets/common_button.dart';
import 'package:sports_trending/widgets/common_svg_images.dart';
import 'package:sports_trending/widgets/custom_text_form_field.dart';

class PhoneSignUpView extends StatelessWidget {
  PhoneSignUpView({super.key});

  final PhoneSignUpController phoneSignUpController = Get.put(
    PhoneSignUpController(),
  );
  final LanguageController languageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAssets.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.1),

          // Logo
          Center(child: CommonSvgImages(image: ImageAssets.splashImg)),

          SizedBox(height: Constant.size30),

          // sign up Form
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(Constant.size20),
                decoration: BoxDecoration(
                  color: ColorAssets.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Constant.size20),
                    topRight: Radius.circular(Constant.size20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      languageController.getLabel("register_now_header"),
                      style: Styles.textStyleWhiteMedium.copyWith(
                        fontSize: FontSize.s18,
                      ),
                    ),
                    SizedBox(height: Constant.size20),

                    Text(
                      languageController.getLabel("name"),
                      style: Styles.textStyleWhiteNormal.copyWith(
                        color: ColorAssets.white,

                        fontSize: FontSize.s13,
                      ),
                    ),
                    SizedBox(height: Constant.size5),
                    CustomTextFormField(
                      input: TextInputAction.next,
                      textInputType: TextInputType.name,
                      controller: phoneSignUpController.nameController,
                      placeHolder: languageController.getLabel(
                        "enter_your_name",
                      ),
                      disableFloatingLabel: true,
                    ),

                    SizedBox(height: Constant.size15),

                    // Email
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
                      controller: phoneSignUpController.emailController,
                      placeHolder: languageController.getLabel("email_empty"),
                      disableFloatingLabel: true,
                    ),

                    SizedBox(height: Constant.size15),

                    // Register Button
                    Obx(
                      () =>
                          phoneSignUpController.isLoading.value
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
                                  "register_now_label",
                                ),
                                onClick: () {
                                  phoneSignUpController.register();
                                },
                              ),
                    ),
                    SizedBox(height: 20),
                    // Login Link
                    Container(
                      alignment: Alignment.center,
                      child: Text.rich(
                        TextSpan(
                          text: languageController.getLabel(
                            "donot_have_account",
                          ),
                          style: Styles.textStyleWhiteNormal.copyWith(
                            color: ColorAssets.grey,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ',
                              style: Styles.textStyleWhiteNormal.copyWith(
                                color: ColorAssets.grey,
                              ),
                            ),
                            TextSpan(
                              text: languageController.getLabel("login_btn"),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () => Get.to(() => LoginView()),
                              style: Styles.textStyleWhiteNormal.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            // can add more TextSpans here...
                          ],
                        ),
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
