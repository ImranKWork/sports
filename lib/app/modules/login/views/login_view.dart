import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sports_trending/app/modules/forgot_password/views/forgot_password_view.dart';
import 'package:sports_trending/app/modules/language/controllers/language_controller.dart';
import 'package:sports_trending/app/modules/login/controllers/login_controller.dart';
import 'package:sports_trending/app/modules/signup/views/signup_view.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/source/image_assets.dart';
import 'package:sports_trending/source/styles.dart';
import 'package:sports_trending/utils/screen_util.dart';
import 'package:sports_trending/utils/string_extension.dart';
import 'package:sports_trending/widgets/common_button.dart';
import 'package:sports_trending/widgets/common_svg_images.dart';
import 'package:sports_trending/widgets/custom_text_form_field.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final LoginController controller = Get.put(LoginController());
  final LanguageController languageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body:
            languageController.isLoading.value
                ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      ColorAssets.themeColorOrange,
                    ),
                  ),
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.1),

                    // Logo
                    Center(
                      child: CommonSvgImages(image: ImageAssets.splashImg),
                    ),

                    SizedBox(height: Constant.size30),

                    // Login Form
                    Expanded(
                      child: Container(
                        height: Get.height,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: ColorAssets.purple,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                languageController.getLabel("login_tag_line"),
                                style: Styles.textStyleWhiteMedium.copyWith(
                                  fontSize: FontSize.s18,
                                ),
                              ),
                              SizedBox(height: 20),

                              Container(
                                decoration: BoxDecoration(
                                  color: ColorAssets.grey,
                                  borderRadius: BorderRadius.circular(8),
                                ),

                                height: Constant.size30,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          controller.setSelectedIndex(0);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                controller
                                                            .selectedIndex
                                                            .value ==
                                                        0
                                                    ? ColorAssets
                                                        .themeColorOrange
                                                    : ColorAssets.grey,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              languageController.getLabel(
                                                "email_header",
                                              ),
                                              style: Styles.textStyleWhiteNormal
                                                  .copyWith(
                                                    color:
                                                        controller
                                                                    .selectedIndex
                                                                    .value ==
                                                                0
                                                            ? ColorAssets.white
                                                            : ColorAssets
                                                                .purple,
                                                    fontSize: FontSize.s13,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          controller.setSelectedIndex(1);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                controller
                                                            .selectedIndex
                                                            .value ==
                                                        1
                                                    ? ColorAssets
                                                        .themeColorOrange
                                                    : ColorAssets.grey,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              languageController.getLabel(
                                                "phone_header",
                                              ),
                                              style: Styles.textStyleWhiteNormal
                                                  .copyWith(
                                                    color:
                                                        controller
                                                                    .selectedIndex
                                                                    .value ==
                                                                1
                                                            ? ColorAssets.white
                                                            : ColorAssets
                                                                .purple,
                                                    fontSize: FontSize.s13,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              // Email / Phone Input
                              controller.selectedIndex.value == 0
                                  ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        languageController.getLabel(
                                          "email_header",
                                        ),
                                        style: Styles.textStyleWhiteMedium
                                            .copyWith(fontSize: FontSize.s14),
                                      ),
                                      SizedBox(height: 5),
                                      CustomTextFormField(
                                        input: TextInputAction.next,
                                        textInputType:
                                            TextInputType.emailAddress,
                                        controller: controller.emailController,
                                        placeHolder: languageController
                                            .getLabel("email_empty"),
                                        disableFloatingLabel: true,
                                      ),

                                      SizedBox(height: Constant.size15),
                                    ],
                                  )
                                  : controller.selectedIndex.value == 1
                                  ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        languageController.getLabel(
                                          "phone_header",
                                        ),
                                        style: Styles.textStyleWhiteMedium
                                            .copyWith(fontSize: FontSize.s14),
                                      ),
                                      SizedBox(height: 5),
                                      // CustomTextFormField(
                                      //   input: TextInputAction.next,
                                      //   textInputType: TextInputType.phone,
                                      //
                                      //   controller: controller.mobileController,
                                      //   placeHolder:
                                      //       "${languageController.getLabel("phone_empty")} (Ex: +1 XXXXXXXXXX)",
                                      //   disableFloatingLabel: true,
                                      // ),
                                      IntlPhoneField(
                                        controller: controller.mobileController,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText:
                                              "${languageController.getLabel("phone_empty")} (Ex: XXXXXXXXXX)",
                                          hintStyle: Styles.textBlackHeader,
                                          border: UnderlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorAssets.white,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              Constant.size8,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              Constant.size8,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              Constant.size8,
                                            ),
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1.0,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      Constant.size8,
                                                    ),
                                                borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: 1.0,
                                                ),
                                              ),
                                          contentPadding: EdgeInsets.all(10),
                                          counterText: "",
                                        ),
                                        initialCountryCode: 'US',
                                        disableLengthCheck: true,
                                        showDropdownIcon: false,
                                        onChanged: (phone) {},
                                        validator: (phone) {
                                          if (phone == null ||
                                              phone.number.isEmpty) {
                                            return 'Phone number is required';
                                          } else if (phone.number.length < 10 ||
                                              phone.number.length > 15) {
                                            return 'Enter a valid phone number';
                                          } else if (!RegExp(
                                            r'^\d+$',
                                          ).hasMatch(phone.number)) {
                                            return 'Phone number should contain only digits';
                                          }
                                          return null;
                                        },
                                      ),

                                      SizedBox(height: Constant.size15),
                                    ],
                                  )
                                  : const SizedBox(),

                              // Password Input
                              if (controller.selectedIndex.value == 0) ...[
                                Text(
                                  languageController.getLabel(
                                    "password_header",
                                  ),
                                  style: Styles.textStyleWhiteNormal,
                                ),
                                SizedBox(height: Constant.size5),

                                CustomTextFormField(
                                  input: TextInputAction.done,
                                  textInputType: TextInputType.text,
                                  controller: controller.passwordController,
                                  obscureText:
                                      controller.isPasswordHidden.value,
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
                                  validator: (value) {
                                    return (value
                                        .toString()
                                        .validatePassword());
                                  },
                                ),
                                SizedBox(height: Constant.size5),

                                Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => ForgotPasswordView());
                                    },
                                    child: Text(
                                      languageController.getLabel(
                                        "forgot_password",
                                      ),
                                      style: Styles.textStyleWhiteMedium
                                          .copyWith(
                                            color: ColorAssets.grey,
                                            fontSize: FontSize.s13,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                              SizedBox(height: 10),
                              if (controller.selectedIndex.value == 0) ...[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,

                                        children: [
                                          InkWell(
                                            onTap:
                                                () =>
                                                    controller
                                                        .toggleRememberMe(),

                                            child: Container(
                                              width: Constant.size20,
                                              height: Constant.size20,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                    Constant.size4,
                                                  ),
                                                ),
                                                border: Border.all(
                                                  color: ColorAssets.grey,
                                                ),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.check,
                                                  size: Constant.size15,
                                                  color:
                                                      controller
                                                              .rememberMe
                                                              .value
                                                          ? ColorAssets
                                                              .themeColorOrange
                                                          : Colors.transparent,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: Constant.size5),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap:
                                                  () =>
                                                      controller
                                                          .toggleRememberMe(),
                                              child: Text(
                                                languageController.getLabel(
                                                  "remember_me",
                                                ),
                                                style: Styles
                                                    .textStyleWhiteMedium
                                                    .copyWith(
                                                      color: ColorAssets.grey,
                                                      fontSize: FontSize.s13,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                              ],

                              // Login Button
                              Obx(
                                () =>
                                    controller.isLoading.value
                                        ? Container(
                                          alignment: Alignment.center,

                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  ColorAssets.themeColorOrange,
                                                ),
                                          ),
                                        )
                                        : CommonButton(
                                          label: languageController.getLabel(
                                            "login_btn",
                                          ),
                                          onClick: () {
                                            controller.login();
                                          },
                                        ),
                              ),

                              SizedBox(height: Constant.size10),

                              // Register
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(
                                  horizontal: Constant.size25,
                                ),
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
                                        style: Styles.textStyleWhiteNormal
                                            .copyWith(color: ColorAssets.grey),
                                      ),
                                      TextSpan(
                                        text: languageController.getLabel(
                                          "register_now_label",
                                        ),
                                        recognizer:
                                            TapGestureRecognizer()
                                              ..onTap =
                                                  () => Get.to(
                                                    () => SignUpView(),
                                                  ),
                                        style: Styles.textStyleWhiteNormal
                                            .copyWith(
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor: Colors.white,
                                              overflow: TextOverflow.clip,
                                            ),
                                      ),
                                      // can add more TextSpans here...
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: Constant.size15),
                              Row(
                                children: [
                                  Expanded(child: Divider(color: Colors.white)),
                                  SizedBox(width: Constant.size10),
                                  Text(
                                    languageController.getLabel(
                                      "or_continue_with",
                                    ),
                                    style: Styles.textStyleWhiteNormal.copyWith(
                                      fontSize: FontSize.s12,
                                    ),
                                  ),
                                  SizedBox(width: Constant.size10),
                                  Expanded(child: Divider(color: Colors.white)),
                                ],
                              ),

                              SizedBox(height: Constant.size15),

                              // Social Media Login
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    socialLoginButton(
                                      "assets/images/youtube.svg",
                                      () {
                                        controller.youTubeLogin();
                                      },
                                    ),
                                    // socialLoginButton(
                                    //   "assets/images/facebook.svg",
                                    //   () {
                                    //     controller.facebookLogin();
                                    //   },
                                    // ),
                                    // socialLoginButton(
                                    //   "assets/images/instagram.svg",
                                    //   () {},
                                    // ),
                                    // socialLoginButton(
                                    //   "assets/images/twitter.svg",
                                    //   () {
                                    //     controller.signInWithTwitter();
                                    //   },
                                    // ),
                                    // if (Platform.isIOS)
                                    socialLoginButton(
                                      "assets/images/apple.svg",
                                      () {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }

  InputDecoration inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  // Social login button widget
  Widget socialLoginButton(String assetPath, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: onTap,
        child: CommonSvgImages(image: assetPath),
      ),
    );
  }
}
