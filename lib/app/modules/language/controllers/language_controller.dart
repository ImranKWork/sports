import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_trending/app/modules/home/views/home_view.dart';
import 'package:sports_trending/app/modules/login/views/login_view.dart';
import 'package:sports_trending/core/shared_preference.dart';
import 'package:sports_trending/model/sign_up/sign_up_response.dart';
import 'package:sports_trending/source/color_assets.dart';
import 'package:sports_trending/utils/api_utils.dart';
import 'package:sports_trending/utils/app_utils.dart';
import 'package:sports_trending/utils/internet_controller.dart';
import 'package:http/http.dart' as http;

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
    Get.to(() => LoginView());
  }

  Future<http.Response> updateProfile(
    String language,
    String userId,
    context,
  ) async {
    isLoading(true);
    final url = Uri.parse('${ApiUtils.BASE_URL}/user/$userId');
    String token = await FirebaseMessaging.instance.getToken() ?? "";
    String deviceId = await AppUtils.getDeviceDetails() ?? "";
    final accessToken = SharedPref.getString(PrefsKey.accessToken);
    debugPrint("uid :$userId");

    Map<String, dynamic> requestBody = {};
    var uid = SharedPref.getString(PrefsKey.key_uid);

    if (language.isNotEmpty) requestBody["language"] = language;

    requestBody["userId"] = uid;

    if (requestBody.isNotEmpty) {
      final response = await http.put(
        url,
        body: jsonEncode(requestBody),
        headers: {
          ApiUtils.DEVICE_ID: deviceId,
          ApiUtils.DEVICE_TOKEN: token,
          ApiUtils.CONTENT_TYPE: ApiUtils.HEADER_TYPE,
          ApiUtils.AUTHORIZATION: accessToken,
        },
      );
      debugPrint("request : $requestBody}");

      if (response.statusCode == 200) {
        isLoading(false);
        debugPrint("response : ${response.body}");
         Get.to(() => HomeView());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(getLabel("lang_update"))),
          snackBarAnimationStyle: AnimationStyle(
            duration: Duration(seconds: 1),
          ),
        );
        return response;
      } else if (response.statusCode == 400) {
        isLoading(false);
        return response;
      } else {
        isLoading(false);
        throw Exception("Failed");
      }
    } else {
      isLoading(false);
      throw Exception("Failed");
    }
  }

  void onDonePressed(firstName, lastname, email, token) {
    SharedPref.setValue(PrefsKey.language, selectedLanguageCode.value);
    updateUser(firstName, lastname, email, token);
  }

  void onDonePressed2(context) {
    SharedPref.setValue(PrefsKey.language, selectedLanguageCode.value);
    String userId = SharedPref.getString(PrefsKey.userId, "");

    updateProfile(selectedLanguageCode.value, userId, context);
  }

  saveUserInfo(SignUpResponseModel signUpResponse) async {
    SharedPref.setValue(PrefsKey.isLoggedIn, true);
    SharedPref.setValue(PrefsKey.userId, signUpResponse.data.id);
    SharedPref.setValue(PrefsKey.fName, signUpResponse.data.firstname);
    SharedPref.setValue(PrefsKey.lName, signUpResponse.data.lastname);
    SharedPref.setValue(PrefsKey.email, signUpResponse.data.email);
    if (signUpResponse.data.phoneNumber.isNotEmpty) {
      SharedPref.setValue(PrefsKey.phoneNo, signUpResponse.data.phoneNumber);
      SharedPref.setValue(
        PrefsKey.phoneNocountry,
        signUpResponse.data.countryCode,
      );
    }
    SharedPref.setValue(PrefsKey.language, signUpResponse.data.language);
    SharedPref.setValue(
      PrefsKey.profilePhoto,
      signUpResponse.data.profileImage,
    );
    SharedPref.setValue(PrefsKey.bio, signUpResponse.data.bio);
    SharedPref.setValue(
      PrefsKey.memberSince,
      signUpResponse.data.createdAt.toIso8601String(),
    );
  }

  Future<void> updateUser(firstName, lastname, email, token) async {
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
    var uid = SharedPref.getString(PrefsKey.key_uid);
    try {
      final register = await apiService.updateUser(
        firstName,
        lastname,
        email,
        uid,
        language: selectedLanguageCode.value,
        token: token,
      );
      if (register.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(register.body);
        final signUpData = SignUpResponseModel.fromJson(responseData);

        // Save the user info using a helper method
        saveUserInfo(signUpData);
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAll(() => HomeView());
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
    String storedLang =
        SharedPref.getString(PrefsKey.language).isEmpty
            ? "en"
            : SharedPref.getString(PrefsKey.language);

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
