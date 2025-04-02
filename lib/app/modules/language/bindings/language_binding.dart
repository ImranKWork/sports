import 'package:get/get.dart';
import 'package:sports_trending/app/modules/language/controllers/language_controller.dart';
import 'package:sports_trending/app/modules/login/controllers/login_controller.dart';

class LanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LanguageController>(() => LanguageController());
  }
}
