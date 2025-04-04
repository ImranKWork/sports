import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_trending/app/modules/home/views/home_view.dart';
import 'package:sports_trending/app/modules/login/views/login_view.dart';
import 'package:sports_trending/core/shared_preference.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/utils/internet_controller.dart';

import '../../../../providers/api_provider.dart';
import '../../signup/controllers/signup_controller.dart';

class LanguageController extends GetxController {
  var selectedLanguage = "English (US)".obs;
  var selectedLanguageCode = "en".obs;
  var defaultSelectedCode = "en".obs;
  var labels = {}.obs;
  var latestVersion = "".obs;
  var isLoading = false.obs;
  final signUpController = Get.put(SignupController());
  final ApiProvider apiService = ApiProvider();
  final internetController = Get.put(InternetController());
  var firstName = "";
  var lastName = "";
  var email = "";
  var token = "";

  void selectLanguage(String language, String code) {
    selectedLanguage.value = language;
    selectedLanguageCode.value = code;
  }

  void onSkipPressed() {
    SharedPref.setValue(PrefsKey.language, defaultSelectedCode.value);
    //updateUser(defaultSelectedCode.value);
    Get.to(() => LoginView());
  }

  void onDonePressed() {
    SharedPref.setValue(PrefsKey.language, selectedLanguageCode.value);
    updateUser(selectedLanguageCode.value);
  }

  Future<void> updateUser(String lang) async {
    final isConnected = await internetController.checkInternet();

    if (!isConnected) {
      Get.snackbar(
        "Internet Error",
        "No internet connection",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );
      return;
    }
    isLoading(true);

    try {
      final register = await apiService.updateUser(
        firstName,
        lastName,
        email,
        lang,
        token: token,
      );
      if (register.statusCode == 200) {
        Future.delayed(const Duration(seconds: 1), () {
<<<<<<< Updated upstream
          Get.offAll(() => HomeView());
=======
          Get.offAll(() => LoginView());
>>>>>>> Stashed changes
        });
      } else {
        Get.snackbar(
          "Error",
          "Failed to update user information",
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
    isLoading(false);
  }

  Future<void> loadLabels() async {
    final isConnected = await internetController.checkInternet();

    if (!isConnected) {
      Get.snackbar(
        "Internet Error",
        "No internet connection",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorAssets.error,
        colorText: Colors.white,
      );
      return;
    }

    // isLoading(true);

    String? storedLabels = SharedPref.getString(PrefsKey.labels);
    String? storedVersion = SharedPref.getString(PrefsKey.version);

    if (storedVersion != latestVersion.value) {
      labels.value = json.decode(storedLabels);
    } else {
      await fetchLabels();
    }
    // isLoading(false);
  }

  Future<void> fetchLabels() async {
    try {
      // isLoading(true);
      final response = await ApiProvider().fetchLabels();

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["message"] == "success") {
          labels.value = data["data"];
          latestVersion.value = data["data"]["Version"];
          await saveLabels(data["data"]);
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load labels");
    } finally {
      // isLoading(false);
    }
  }

  /*
  String getLabel(String key, {String lang = "en"}) {
    String? storedLang = SharedPref.getString(PrefsKey.language, "en");

    if (labels.isNotEmpty && labels[storedLang] != null) {
      return labels[storedLang][key].toString();
    } else {
      return labels[lang][key] ?? key;
    }
  }*/
  String getLabel(String key, {String lang = "en"}) {
    String storedLang = SharedPref.getString(PrefsKey.language) ?? "en";

    if (labels.isNotEmpty &&
        labels[storedLang] != null &&
        labels[storedLang][key] != null) {
      return labels[storedLang][key].toString();
    } else if (labels[lang] != null && labels[lang][key] != null) {
      return labels[lang][key].toString();
    } else {
      return key;
    }
  }

  Future<void> saveLabels(Map<String, dynamic> labelsData) async {
    await SharedPref.setValue(PrefsKey.labels, json.encode(labelsData));
    await SharedPref.setValue(PrefsKey.version, labelsData["Version"]);
  }
}
