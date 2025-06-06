import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sports_trending/app/modules/edit_profile/controllers/edit_profile_controller.dart';
import 'package:sports_trending/app/modules/login/controllers/login_controller.dart';
import 'package:sports_trending/core/shared_preference.dart';
import 'package:sports_trending/model/sign_up/sign_up_response.dart';
import 'package:sports_trending/providers/api_provider.dart';
import 'package:sports_trending/utils/image_picker_controller.dart';
import 'package:sports_trending/widgets/common_button.dart';

import '../../../../source/color_assets.dart';
import '../../../../source/styles.dart';
import '../../../../utils/screen_util.dart';
import '../../language/controllers/language_controller.dart';

class ProfileController extends GetxController {
  final count = 0.obs;
  final imagePickerController = Get.put(ImageController());
  final editProfileController = Get.put(EditProfileController());
  final loginController = Get.put(LoginController());
  var isLoading = false.obs;
  final ApiProvider apiService = ApiProvider();
  final LanguageController languageController = Get.find();

  @override
  void onInit() {
    super.onInit();
    getProfileById();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    isLoading.value = false;
    super.onClose();
  }

  void increment() => count.value++;

  Future getProfileById() async {
    final userId = SharedPref.getString(PrefsKey.userId);
    isLoading(true);

    try {
      final response = await apiService.getProfileById(userId);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final signUpData = SignUpResponseModel.fromJson(responseData);
        debugPrint("profile info : $signUpData");
        loginController.saveUserInfo(signUpData);
        await SharedPref.setValue(
          PrefsKey.userstcoin,
          responseData["data"]["STPoints"].toString(),
        );
        await SharedPref.setValue(
          PrefsKey.userchallengecount,
          responseData["data"]["engagementMetrics"]["Challenges"].toString(),
        );
        debugPrint("name : ${SharedPref.getString(PrefsKey.fName)}");
      } else {
        Get.snackbar(
          languageController.getLabel("error"),
          languageController.getLabel("failed_to_fetch_user_information"),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      isLoading(false);
    } catch (e) {
      isLoading(false);
      // Get.snackbar(
      //   languageController.getLabel("error"),
      //   languageController.getLabel(
      //     "an_unexpected_error_occurred._please_try_again_later.",
      //   ),
      //   snackPosition: SnackPosition.BOTTOM,
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
    }
  }

  showEditProfileDialog() {
    Get.defaultDialog(
      title: languageController.getLabel("change_profile"),

      titleStyle: Styles.textStyleBlackMedium.copyWith(fontSize: FontSize.s18),
      content: Column(
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text(
              languageController.getLabel("select_with_camera"),
              style: Styles.textStyleBlackMedium.copyWith(
                fontSize: FontSize.s14,
              ),
            ),
            onTap: () async {
              final file = await imagePickerController.pickImage(
                ImageSource.camera,
              );
              final userId = SharedPref.getString(PrefsKey.userId);
              if (file.value?.path != null) {
                if (imagePickerController.validateImage(file.value!)) {
                  editProfileController.updatePhoto(file.value!.path, userId);
                }
              }
              Get.back();
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text(
              languageController.getLabel("select_with_gallery"),

              style: Styles.textStyleBlackMedium.copyWith(
                fontSize: FontSize.s14,
              ),
            ),
            onTap: () async {
              final file = await imagePickerController.pickImage(
                ImageSource.gallery,
              );
              final userId = SharedPref.getString(PrefsKey.userId);
              if (file.value?.path != null) {
                if (imagePickerController.validateImage(file.value!)) {
                  editProfileController.updatePhoto(file.value!.path, userId);
                }
              }
              Get.back();
            },
          ),
        ],
      ),

      cancel: Padding(
        padding: EdgeInsets.symmetric(horizontal: Constant.size80),
        child: CommonButton(
          label: languageController.getLabel("name"),
          onClick: () {
            Get.back();
          },
        ),
      ),
      cancelTextColor: ColorAssets.white,
    );
  }
}
