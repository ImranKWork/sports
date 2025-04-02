import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sports_trending/source/color_assets.dart';

class ImageController extends GetxController {
  var selectedImage = Rxn<File>();

  Future<Rxn<File>> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      selectedImage.value = File(image.path);
      debugPrint("selected img:${selectedImage.value}");
      return selectedImage;
    } else {
      Get.snackbar("No Image Selected", "Please choose an image.");
      return Rxn<File>();
    }
  }

  bool validateImage(File image) {
    // Check if the selected image file is not empty and has a valid extension
    String extension = image.path.split('.').last;
    if (extension != 'jpg' && extension != 'jpeg' && extension != 'png') {
      Get.snackbar(
        "Error",
        'Please select a valid image (JPG, PNG).',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: ColorAssets.white,
      );
      return false;
    } else if (image.lengthSync() > 2 * 1024 * 1024) {
      Get.snackbar(
        "Error",
        'Image is too large. Max size is 2MB.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: ColorAssets.white,
      );
      return false;// 2MB size limit
    } else {
      return true;
    }
  }
}
