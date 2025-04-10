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

class ProfileController extends GetxController {
  final count = 0.obs;
  final imagePickerController = Get.put(ImageController());
  final editProfileController = Get.put(EditProfileController());
  final loginController = Get.put(LoginController());
  var isLoading = false.obs;
  final ApiProvider apiService = ApiProvider();

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

        // Save the user info using a helper method
        loginController.saveUserInfo(signUpData);
        debugPrint("name : ${SharedPref.getString(PrefsKey.fName)}");
      } else {
        Get.snackbar(
          "Error",
          "Failed to fetch user information",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      isLoading(false);
    } catch (e) {
      isLoading(false);
      // Catch any errors that occur during the API call or data processing
      Get.snackbar(
        "Error",
        "An unexpected error occurred. Please try again later.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  showEditProfileDialog() {
    Get.defaultDialog(
      title: "Change profile",
      titleStyle: Styles.textStyleBlackMedium.copyWith(fontSize: FontSize.s18),
      content: Column(
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text(
              "Select with Camera",
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
              "Select with Gallery",
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
          label: "Cancel",
          onClick: () {
            Get.back();
          },
        ),
      ),
      cancelTextColor: ColorAssets.white,
    );
  }
}
