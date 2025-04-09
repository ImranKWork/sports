import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_trending/app/modules/language/controllers/language_controller.dart';
import 'package:sports_trending/app/modules/login/views/login_view.dart';
import 'package:sports_trending/app/modules/signup/controllers/signup_controller.dart';
import 'package:sports_trending/app/modules/signup/views/privacy_policy_view.dart';
import 'package:sports_trending/app/modules/signup/views/terms_policy.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/source/image_assets.dart';
import 'package:sports_trending/source/styles.dart';
import 'package:sports_trending/utils/screen_util.dart';
import 'package:sports_trending/widgets/common_button.dart';
import 'package:sports_trending/widgets/common_svg_images.dart';
import 'package:sports_trending/widgets/custom_text_form_field.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final SignupController controller = Get.put(SignupController());
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

          // Login Form
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: Get.height / 1.2,
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
                      controller: controller.nameController,
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
                      controller: controller.emailController,
                      placeHolder: languageController.getLabel("email_empty"),
                      disableFloatingLabel: true,
                    ),

                    SizedBox(height: Constant.size15),

                    // Password Input
                    Text(
                      languageController.getLabel("password_header"),
                      style: Styles.textStyleWhiteNormal.copyWith(
                        color: ColorAssets.white,

                        fontSize: FontSize.s13,
                      ),
                    ),
                    SizedBox(height: Constant.size5),

                    Obx(() {
                      return CustomTextFormField(
                        input: TextInputAction.next,
                        textInputType: TextInputType.text,
                        controller: controller.passwordController,
                        obscureText: controller.isPasswordHidden.value,
                        placeHolder: languageController.getLabel(
                          "enter_password",
                        ),
                        disableFloatingLabel: true,
                        suffixOnClick: () {
                          controller.togglePasswordVisibility();
                        },
                        suffixIcon:
                            controller.isPasswordHidden.value
                                ? ImageAssets.passwordHide
                                : ImageAssets.passwordShow,
                      );
                    }),

                    SizedBox(height: Constant.size15),

                    Text(
                      languageController.getLabel("confirm_password"),
                      style: Styles.textStyleWhiteNormal.copyWith(
                        color: ColorAssets.white,

                        fontSize: FontSize.s13,
                      ),
                    ),
                    SizedBox(height: Constant.size5),

                    Obx(() {
                      return CustomTextFormField(
                        input: TextInputAction.next,
                        textInputType: TextInputType.text,
                        controller: controller.confirmPasswordController,
                        obscureText: controller.isConfirmPasswordHidden.value,
                        placeHolder: languageController.getLabel(
                          "enter_confirm_password",
                        ),
                        disableFloatingLabel: true,
                        suffixOnClick: () {
                          controller.toggleConfirmPasswordVisibility();
                        },
                        suffixIcon:
                            controller.isConfirmPasswordHidden.value
                                ? ImageAssets.passwordHide
                                : ImageAssets.passwordShow,
                      );
                    }),

                    SizedBox(height: Constant.size15),

                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap:
                                () => controller.termConditionPrivacyPolicy(),

                            child: Container(
                              width: Constant.size20,
                              height: Constant.size20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(Constant.size4),
                                ),
                                border: Border.all(color: ColorAssets.grey),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.check,
                                  size: Constant.size15,
                                  color:
                                      controller.isIAgree.value
                                          ? ColorAssets.themeColorOrange
                                          : Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: Constant.size10),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                text: languageController.getLabel(
                                  "iagreetolabel",
                                ),
                                style: Styles.textStyleWhiteNormal.copyWith(
                                  color: ColorAssets.grey,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: languageController.getLabel(
                                      "termconditions",
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.to(() => TermsPolicyView());
                                          },
                                    style: Styles.textStyleWhiteNormal.copyWith(
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.white,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' & ',
                                    style: Styles.textStyleWhiteNormal,
                                  ),
                                  TextSpan(
                                    text: languageController.getLabel(
                                      "privacypolicy",
                                    ),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.to(() => PrivacyPolicyView());
                                          },
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

                    SizedBox(height: Constant.size20),

                    // Register Button
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
                                  "register_now_label",
                                ),
                                onClick: () {
                                  controller.register();
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
