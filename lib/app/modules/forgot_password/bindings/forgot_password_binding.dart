import 'package:get/get.dart';
import 'package:sports_trending/app/modules/forgot_password/controllers/forgot_password_controller.dart';


class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(()=>
        ForgotPasswordController());
  }
}