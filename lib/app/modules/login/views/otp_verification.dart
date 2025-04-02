import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sports_trending/app/modules/login/controllers/login_controller.dart';

import 'package:sports_trending/app/modules/login/controllers/otp_verification_controller.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/source/image_assets.dart';
import 'package:sports_trending/source/styles.dart';
import 'package:sports_trending/utils/screen_util.dart';
import 'package:sports_trending/widgets/common_button.dart';
import 'package:sports_trending/widgets/common_svg_images.dart';

import '../../../../widgets/custom_text_form_field.dart';
import '../../language/controllers/language_controller.dart';

class OtpVerificationView extends StatelessWidget {
  OtpVerificationView({super.key, required this.verificationId, required this.phoneNo});

  final String verificationId, phoneNo;
  final OtpVerificationController controller = Get.put(
    OtpVerificationController(),
  );
  final LoginController loginController = Get.put(
    LoginController(),
  );

  final LanguageController languageController = Get.find();

  @override
  Widget build(BuildContext context) {

    controller.vId = verificationId;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop,_) async{
        if (didPop) {
          return;
        }
        Get.back(result: controller.resendTimer.value);
      },
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.1),

                // Logo
                Center(child: CommonSvgImages(image: ImageAssets.splashImg)),

                SizedBox(height: Constant.size30),

                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      height: Get.height,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: ColorAssets.black,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            languageController.getLabel("otp_verification_tag_line"),
                            style: Styles.textStyleWhiteMedium.copyWith(
                              fontSize: FontSize.s18,
                            ),
                          ),
                          SizedBox(height: Constant.size20),

                          CustomTextFormField(
                            input: TextInputAction.done,
                            textInputType: TextInputType.number,
                            maxLength: 6,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              // Allow only digits
                              LengthLimitingTextInputFormatter(6),
                            ],
                            controller: controller.otpController,

                            placeHolder: languageController.getLabel(
                              "enter_your_otp",
                            ),
                            disableFloatingLabel: true,
                          ),
                          SizedBox(height: Constant.size10),

                          Obx(
                            () => Center(
                              child: Text(
                                controller.resendTimer.value > 0
                                    ? "Resend OTP in ${controller.resendTimer.value} sec"
                                    : "You can resend OTP now",
                                style: TextStyle(fontSize: 11, color: Colors.white),
                              ),
                            ),
                          ),

                          SizedBox(height: Constant.size20),
                          Obx(
                            () =>  controller.resendTimer.value > 0  ?
                              const SizedBox() :
                              GestureDetector(
                              onTap: () {
                                controller.resendOTP(phoneNo);
                              },
                              child: Center(
                                child: Text(
                                  languageController.getLabel("resend_otp"),

                                  style: Styles.textStyleWhiteMedium.copyWith(
                                    fontSize: FontSize.s14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: Constant.size10),

                          CommonButton(
                            label: languageController.getLabel("verify_otp"),
                            onClick: () {
                              controller.verifyOtp();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Obx(() => Visibility(
                visible: controller.isLoading.value,
                child: Center(
              child: CircularProgressIndicator(
                valueColor:
                AlwaysStoppedAnimation<Color>(
                  ColorAssets.themeColorOrange,
                ),
              ),
            )))
          ],
        ),
      ),
    );
  }
}
