import 'package:get/get.dart';

import 'package:sports_trending/app/modules/login/controllers/otp_verification_controller.dart';

class OtpVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpVerificationController>(() => OtpVerificationController());
  }
}
